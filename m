Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390E33876C9;
	Mon, 27 Jul 2026 14:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785163114; cv=none; b=EJhPCpGEd9XihXYZRaL+ZtSo2owpoDVJx2PIg7Ws34yqBhwojU94QiDsV2M9Km+AOKhlozirrtlCS+vnPvcE5HKBSOMK1i259LKq5r3DUbMu63xcLai5PjvDad0LkDYP1EcxMdAaYmO8pBYAHtBG9F0Uy+FAu/Jtvu92gsAogI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785163114; c=relaxed/simple;
	bh=jpq/IlpRlDFv3aOnFkdxRMPdHVCj+SY7//xXwyTTJK4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RwsmeDVBc0KAn9c0nKVlpS423imLu+vZg0Xfafr6y8NX6phHlBxKjnsawPfTosMA3oA1tlB6Tmqdc+301tHTOCO5wdnp/kP7nasvpizzTNvBR3EbhCkpjenVr1BhIrV5PkHIGazrna5opnmMINMyNJDS+29eZ8QEdAqj7F4a0Ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PvnecD8j; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PvnecD8j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED10A1F00A3D;
	Mon, 27 Jul 2026 14:38:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785163113;
	bh=g9G+NjVl63rSPH9VnWm2f5oghlS13iCb5rZjc3IcuDc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PvnecD8jMTPG5fONQAI6m6r/a5uh8hfPwMCRQ0JpapBOJOQU8SLD7qYcx1FqqCQjo
	 HwsSTc4AYGmO0I8IQxL2z84PH8O0U0iyi4cQXxo+39d5ksIiejdNSyWFtN9tplCAbi
	 h/8tYiwgy+s3t2a2ijzbSZmtxR1FdS/hEjBasVXkQ1Fsg96q5+6HSYQY6w7h0KkACp
	 RLCXz/acniIZ0jobh894cS/qlXhkesq5cm1CWFV01EMAPT1ObYZ+baL3etEIaT3dpH
	 OqF6SPYN23SXVfkdYUGORUjiOR+C3UxZx1Q+esSKCS3hQPDZkgr75BMZSz/xWMR/Ej
	 9USRBVfXO5MVg==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2.1 02/17] mm/damon/paddr: support PGIDLE_UNSET probe filter type
Date: Mon, 27 Jul 2026 07:38:11 -0700
Message-ID: <20260727143829.86236-3-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260727143829.86236-1-sj@kernel.org>
References: <20260727143829.86236-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement support of DAMON_FILTER_TYPE_PGIDLE_UNSET in the physical
address space DAMON operations set.  It reuses damon_folio_young(),
which was being used for access monitoring.

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/paddr.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index 5c6c3a597fd0b..5b307dcbb2a50 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -132,6 +132,12 @@ static bool damon_pa_filter_match(struct damon_filter *filter,
 			matched = filter->memcg_id == mem_cgroup_id(memcg);
 		rcu_read_unlock();
 		break;
+	case DAMON_FILTER_TYPE_PGIDLE_UNSET:
+		if (!folio)
+			matched = false;
+		else
+			matched = damon_folio_young(folio);
+		break;
 	default:
 		break;
 	}
-- 
2.47.3
