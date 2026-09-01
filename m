Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E1A39F187;
	Tue,  1 Sep 2026 04:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788237272; cv=none; b=NO4eA/B4wg8xGoZAifIq6quqLbf/bvf9hMcu03te0QjtzLTb0pg4oMGjc2NOIN0P59RhcRVNNTLfnw9bavNqtPfpWO7d+UBYXpbWHqDgFEs40E9Coxpkr5OOb9UKILYtvGXC7jC6oKYbBFMb9t1agSiuHMus6tCqFuq+aguAWU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788237272; c=relaxed/simple;
	bh=AsHoCbwMwQPn54Uh42zQM6XfaiQXavuQ492jVm131qQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VHl11nsPFAWumELyxPQOfNLZ9jdfTQfbiWRJNt+L2A7Dig3NPbC3hZiguBlhYILOFRxtMdxS9b56V0UKrtTZEv41dbG8y8REuAQFbr1BYFu6kfsgc3Xk94hNKMq34ot4284EcSUaVcamZVFxpCrKKbaJLwHnC0pZ2rvqcOVUiG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d4qUsh8V; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d4qUsh8V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88F3E1F00ACA;
	Tue,  1 Sep 2026 04:34:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788237271;
	bh=CpXkgOmW3GSwhrOkMdO/S1mj76NXWWV8m3WM4J70bcE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=d4qUsh8VH6LG0mrJ6UNN3Jmg4osXJJohaxTB0Tj3iJ77xaBCrcot88uzDIWSNkDZi
	 UEeh4znBav5abJT/ZG696xoT7Al9mWLGavrWxSRxE0tFzqDQ3fTGk/u3JZ+Q95ztEP
	 SLBmtPKBwaHdUmeq4fJOW8jQbnfWXbElgjXM/Xwqu8w0/uOpUb/Eay/Bcit2poEAeF
	 F2nC4/Id69cJkDxkrqC4I/zbYbB7lsBC0NvXzca7jfHBC62I5ex3SbseQ979G/hJgs
	 VftSP7PQYTafZz2PyBGVmlL458eRpXYo/vHjdBO1JPqKOUxp5CNsCVK/N/pn77+o53
	 h1NoDO/LgNPEA==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	David Hildenbrand <david@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	damon@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 15/17] Docs/mm/damon/design: document probe preps
Date: Mon, 31 Aug 2026 21:34:11 -0700
Message-ID: <20260901043417.2165-16-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260901043417.2165-1-sj@kernel.org>
References: <20260901043417.2165-1-sj@kernel.org>
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
index 947d91ae24a39..d036340dae8af 100644
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
