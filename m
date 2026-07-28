Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57414388E62;
	Tue, 28 Jul 2026 04:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785211981; cv=none; b=enRNgROkEZVpvkEFzO3FdfnzWPNiioN56dSYY1eMRsi/ZLaqlKBcXUEMX7WY/oGFmcJMjmoM4tCq706cnO2CZdwkHIB9mjtOJXPDTXNKHYBbpmrFU6QRiOHz7UmkB71IJzllnQzbRgrgnp877M8Jz6Tc8vhl0tfxzIertDnRGU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785211981; c=relaxed/simple;
	bh=xcWvcxTShuREolgVeaNKxOb9JPpBPwIcsH+2uXlYsDc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iypS9u1WBJWtBZZ5czCkToDYpaEcf03JBIOFrHCNNHgrr9dtrLb/7W1s7lmJ0msCmMM0N/E33uNEWWFxZCpVhq7gbMXX+uoI6DMcwq19KhEiCH5UYfwg2Ku8wQoqUDhR+QiTrR4hxQ1pMTZiO8k1QnqPAe8q36G7iZsSaDFaELw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NCRNd9zy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NCRNd9zy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18EF91F0155B;
	Tue, 28 Jul 2026 04:12:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785211977;
	bh=W5EHzuEPBttna1pHulKblhjSxz0ZvxjVFhC8U+crJAs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NCRNd9zyj03vt8HhyG/dRw2Jd/KNZwx5JqnVm51nuuNO6R7PxTNgwXbVh0dyaN6aU
	 xZeOoBOnDTH8OScjrOHujJd2sRPOR52mPne/5+zmMLyzJV4eit8qIFfUqzkF8BcD8Z
	 nAnnWnJ2vT5Eyn2pQmbvfsa/53don3XRdMdT1Zp8LrtaCkdh8zMbGeJI05tSigWx/Z
	 SEl02vzaT0SuUOksTou01bAN7s+nt9d8nzgT3KmoIoTcStvxzNzAbfAgKXK5HV3ibB
	 JyVXT8C/YGDzUufUpRn6OaFvpGZUsq7UHszKtoQDWRx9+ugto1lR6j1rhfSk+dl7X1
	 ItxxlmphMOafg==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
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
Subject: [RFC PATCH v2.2 15/17] Docs/mm/damon/design: document probe preps
Date: Mon, 27 Jul 2026 21:12:36 -0700
Message-ID: <20260728041242.187380-16-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260728041242.187380-1-sj@kernel.org>
References: <20260728041242.187380-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update DAMON design document for the newly added DAMON probe preps
feature.

Signed-off-by: SJ Park <sj@kernel.org>
---
 Documentation/mm/damon/design.rst | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
index c4830bd09498d..7f983e0c39b80 100644
--- a/Documentation/mm/damon/design.rst
+++ b/Documentation/mm/damon/design.rst
@@ -309,6 +309,13 @@ Users can therefore know how much of a given DAMON region has a specific data
 attribute by reading the per-region per-probe probe hits counter after each
 aggregation interval.
 
+Users can optionally register probing preparation actions per probe.  If such
+actions are registered, DAMON applies the actions to each region's sampling
+memory before starting the next sampling interval.  Currently only one action,
+``set_pgidle`` is supported.  The action marks the page for the probing target
+memory as access-idle.  This can be useful to be used together with
+``pgidle_unset`` probe filter.
+
 This is a sampling based mechanism.  Hence, it is lightweight but the output
 may include some measurement errors.  The output should be used with good
 understanding of statistics.
-- 
2.47.3
