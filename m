Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 621ED2E8DEB;
	Sat, 25 Jul 2026 21:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785013356; cv=none; b=P0O+KhlXIZQ9JkqOjRh9EvayJ5HYZG2ehz+YP9YNzEH1MDbBgPPb4pYZRJfc6qHBTxyuYW0vSQgM/oLgwNwwrFmLiuAau+iK+TJLH8MwQPYeQX3gkoy/aihDHSsd8VZf3wjJihtqH0/T9IO4LO33Cy+xqudOXCz7bu3zLKvHVtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785013356; c=relaxed/simple;
	bh=8Es9t85Bo0rhryEbzvuu9esxBebv1o6si/8zbB0v64k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h/z8g2WlqXHrm3wed+99BcdF5fUgVQqki8bY/Nnj39qYh9T4n9f720rbgn6POS1laQKH40Dnvh6otQYvWjbvUIfeVwHI9cr+JUSvspa4qtwWMl2EgQ1Ul6m8QnF2yMnZaLtiuZOudTHs/5Xbao8x4VXQzxXeolE0dk7qj8vH2a8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lFj7w8nV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lFj7w8nV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 131981F00A3D;
	Sat, 25 Jul 2026 21:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785013355;
	bh=TO6lwsfm9yD3fzAHYwk5XK83WiQ4wpFTJMXF7vsoc7c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lFj7w8nVTqEB2buErY1jl7xXmFwvOsim1E4NC8kbWZ1Qu6ooxtvrGd6YXzcAQkTdg
	 Huw77UQNc2rm5KMoemylpLcMRVMSPHigiTHKzg/t9uY3/VdfAN1ntVNsgNA+U0eqB4
	 iaqK9aLDyKuYEnpgL/Szwhh3z1hVG6cTy+0cmEJqzAfzk3E8gxS+P5eeo1+p0Hl6jl
	 Hzynus+xvrYy/UPDb7vQAHnlOfK9IWKCjjFzKfUxsDbtovxAdbn5C1u07kuZH3VSJz
	 pZiCj/CTaMxoyWevhx4ZzkNNwCyCVoViZ158VU0Mjg6C6kA8iDkD/2xA3X/e02UM1P
	 AlqQOdScGPs0g==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 02/17] mm/damon/paddr: support PGIDLE_UNSET probe filter type
Date: Sat, 25 Jul 2026 14:02:06 -0700
Message-ID: <20260725210225.129944-3-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260725210225.129944-1-sj@kernel.org>
References: <20260725210225.129944-1-sj@kernel.org>
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
index 5a6a78054784a..199de1463fa06 100644
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
