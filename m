Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 965EB3CC338;
	Tue, 12 May 2026 14:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778596628; cv=none; b=s+0E41I6l9kT9rM76klDnCucUL+Ctv8TkbnVxrLteTM0VTR8L+UUtxlbiojOFGDq+uXfCasKO6MJvb5YiaglolNjaINP/26XhA0y5y5E2FevE+HEa6KUzwMF/aCmbi5qsXSFwDTVgk/VFWKr9RsPkyfAoaI28OZ+5yXE1pvAz1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778596628; c=relaxed/simple;
	bh=rQroR8oz509qjIfFzIS58y8CMFJSjy+X56KqeqKaBmA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uP3XxNV3ivPxKKMb7UqYGTpUOs8Z9fT5GSa87X+ej493MzNHgLMn24nYPzpx+9MUE/kYOTTH+Iu19H6v56uT/GoJTMQCbVZDLcx7Y7WFh8R1DBpnq0e5MEypUAGdlTkMaPaQNy3ocDQRq9lI1F72F2bWrT988rR2IqWmeyQymhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lySn+Q/V; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lySn+Q/V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E99C0C2BCB0;
	Tue, 12 May 2026 14:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778596628;
	bh=rQroR8oz509qjIfFzIS58y8CMFJSjy+X56KqeqKaBmA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lySn+Q/VESrFSVgvneHkZvPUuH0oeH/v5CsIOjbXjLI2XNO+e7aQmUL9DWTyON/wg
	 4BuEJ3UQVJZ6CEBMhjWjpSJBRG1GMK/c0uOdJc9p4jW92qpnEDuEVaYEptORPlsy1F
	 6k0Ixw/f6PHgVnoNEjFWfq95Q//ImBoYOUdk230L+6GvlyBsgrq1Hf/TFAPgKVF9yC
	 qOGAasX8/lFRurzkMad+W4/wTjoglvMGAyM0+Uf4gZkWaY0FlpGOLghX7KTkyVtXZX
	 8jgCxdDyv2zbJF3quNdJ9XzQYXeNyCZE8whcPa/COZzUPP2Dy6PWVmzLQhT/sYUR/t
	 384NfyjTILcsw==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
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
Subject: [RFC PATCH v2 27/28] Docs/mm/damon/design: update for memcg damon filter
Date: Tue, 12 May 2026 07:36:42 -0700
Message-ID: <20260512143645.113201-28-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260512143645.113201-1-sj@kernel.org>
References: <20260512143645.113201-1-sj@kernel.org>
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
index 887b45cbeb716..a24f9f00d1837 100644
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
