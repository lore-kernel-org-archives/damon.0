Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B433B19D2;
	Mon, 18 May 2026 23:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779147694; cv=none; b=g4RpWNO8dJFRfNwC2K8nvviJCHjn9PUeVZUbUD5xpHfcz88fE9tnEBW/GSVe+k/fRCSE1qdx06ZZvxtSSaWiWTdbb2QLNDM0bdgVf4/Uf21sn1rh6gny9d0RA597Ads5vLlU14mZOXr1Ohzo7LhQ3BEaZ9n18GAWNrMypAT3HPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779147694; c=relaxed/simple;
	bh=nrsABmJnRfG9DLDHrsalCtHOuyMv2VWZvo4tqHnGPDk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sqp1ROxgs/SSZTutXTy5GCAFugtyLLS0PcPJuWHmp37o8DOjPd/MWlppdYu4y87NptK/6tp1sKxNvlsRA0n+tI9G6/D9kvB+jg/bVX5pUak36g9knJvJaht9cxOvuli5lLvUjtnV89rsjHLdXwx+jNeUSsZv4FNM22CzQDJaP+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d49e4zgQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d49e4zgQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A08CC2BCB7;
	Mon, 18 May 2026 23:41:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779147694;
	bh=nrsABmJnRfG9DLDHrsalCtHOuyMv2VWZvo4tqHnGPDk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d49e4zgQExuGINRxEf5AWO8nZAgQXWtelBWGpn1NMEWBzaksn2d3KfKUKieotlrpt
	 h4cwaSTq82DQ78IKrFyL4vrwbAAANtYApc45EkAKHec0cCfWKSoAFVqTJz4C4phgOp
	 JkGOcScHZ9Gbb6SN+oD6pCnmPxCPaUfZ6Wsh6K4QtqyLmUkqACBAXwsex97lntkS4c
	 bWfBiQFPEMh+0qUofHh5TfyXJ2/h51vsZJHzlka6yPmYMiXnjbIfAFJeNC/VbotLjc
	 uB7786B+psNCQx49QDu4fqK6gD0hKvud+C5xjEczoZ5CDUCU9mLwtLUD2t0GKJ22Af
	 hKQ/cykC4X+HQ==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	David Hildenbrand <david@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	damon@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 27/28] Docs/mm/damon/design: update for memcg damon filter
Date: Mon, 18 May 2026 16:41:15 -0700
Message-ID: <20260518234119.97569-28-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260518234119.97569-1-sj@kernel.org>
References: <20260518234119.97569-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update DAMON design document for the newly added belonging memory cgroup
attribute monitoring feature.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/mm/damon/design.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
index 937960d2b6d73..2da7ca0d3d17a 100644
--- a/Documentation/mm/damon/design.rst
+++ b/Documentation/mm/damon/design.rst
@@ -293,8 +293,8 @@ registration is made by specifying a probe per attribute.  Each of the probe
 specifies a rule to determine if a given memory region has the related
 attribute.  The rule is constructed with multiple filters.  The filters work
 same to :ref:`DAMOS filters <damon_design_damos_filters>` except the supported
-filter types.  Currently only ``anon`` filter type is supported for data
-attributes monitoring.
+filter types.  Currently only ``anon`` and ``memcg`` filter types are supported
+for data attributes monitoring.
 
 If such probes are registered, DAMON executes the probes for each region's
 sampling memory when it does the access :ref:`sampling
-- 
2.47.3
