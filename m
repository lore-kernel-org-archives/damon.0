Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D752641ED;
	Thu, 20 Feb 2025 19:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740080116; cv=none; b=oFX7zi9E5tzAzJLitd12aAosdafNsGW7/AJGjgYuxNyycOc4Lo9xKINVtyc+B1GcC4sdCH+ryQHc7smlX+WyjPZqybeh2v6oewAvt41uJjnFUTjoPfNm99IDQq4NlV/HK8cjmFx2eaQAuPb4M32HeALXYNzPLcAYr3iLoJwjPFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740080116; c=relaxed/simple;
	bh=9/Gqh5HBFp5EuQgZh8Vsw0TLf0LkxPqdJjQTIPzuVw0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=r/Ar54F5/XLMJm/UBLjpFSesUOp4h3mOTgDmF/8ck8Hls1WyDEiAUUJ/ntsMVJ9hX19BIHrNe45d0cT1KpXGcAnje5qXIOZHDWBbDOI4X09KPV8XlzSuz9DDfTK0YBIaup4RIgcH8HimBm+PQU0LHa3QGU3cdfSfP4CsLysdzzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gV/svjnb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gV/svjnb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CB6EC4CED6;
	Thu, 20 Feb 2025 19:35:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740080116;
	bh=9/Gqh5HBFp5EuQgZh8Vsw0TLf0LkxPqdJjQTIPzuVw0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gV/svjnbc/hLOZlrJ/7AWMBpbwF4SUEljC2gTcd5iUQg//lYy3q2XGpomCkt6SsMZ
	 EbUHIikzp2M4Xds61ge0YSxndS7aY2qTe7BOlC7PeKyt/vgOFi/yJyosLa8Nw39dwH
	 kAgiwCAOaACRx0U8CDDHJRiCWg+ASaw4nxsMljcMKN0y7kekkbjBroGDsRy/TjzUWf
	 zo6u33V+SQ1HZfg/muPUFwD1PxiuhWQpIp3qIUYKoXXKg74I+AyUFCMkOlM8tPsHRT
	 OcSr8pdqkaqXYaY/mcruftESTSQ4ny0KwZw15Ll9/ExWQF2kB8cKib5G3JJ6hctczR
	 xsTTQ+rcM8wXQ==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 2/9] mm/damon/paddr: support ops_filters
Date: Thu, 20 Feb 2025 11:35:02 -0800
Message-Id: <20250220193509.36379-3-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250220193509.36379-1-sj@kernel.org>
References: <20250220193509.36379-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON keeps all DAMOS filters in damos->filters, and will make
damos->ops_filters to have all operations layer handled DAMOS filters
with upcoming changes.  But DAMON physical address space operations set
implementation (paddr) is handling only damos->filters.  To avoid any
breakage during the upcoming change, make paddr to handle both.  After
the change is made, ->filters support on paddr can be safely removed.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/paddr.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index 25090230da17..3e651308ba5d 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -257,6 +257,10 @@ static bool damos_pa_filter_out(struct damos *scheme, struct folio *folio)
 		if (damos_pa_filter_match(filter, folio))
 			return !filter->allow;
 	}
+	damos_for_each_ops_filter(filter, scheme) {
+		if (damos_pa_filter_match(filter, folio))
+			return !filter->allow;
+	}
 	return false;
 }
 
@@ -287,6 +291,12 @@ static unsigned long damon_pa_pageout(struct damon_region *r, struct damos *s,
 			break;
 		}
 	}
+	damos_for_each_ops_filter(filter, s) {
+		if (filter->type == DAMOS_FILTER_TYPE_YOUNG) {
+			install_young_filter = false;
+			break;
+		}
+	}
 	if (install_young_filter) {
 		filter = damos_new_filter(
 				DAMOS_FILTER_TYPE_YOUNG, true, false);
@@ -535,6 +545,8 @@ static bool damon_pa_scheme_has_filter(struct damos *s)
 
 	damos_for_each_filter(f, s)
 		return true;
+	damos_for_each_ops_filter(f, s)
+		return true;
 	return false;
 }
 
-- 
2.39.5
