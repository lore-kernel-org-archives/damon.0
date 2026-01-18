Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB6412FE58F;
	Sun, 18 Jan 2026 18:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768759392; cv=none; b=ibUpcQ6bQo3SJqTIOjWkPLEGdWJCjPvKeo6Aq00SUv2cYiTO2Xj/G6wwklwQmJ1ob8C1qncDWKtZdWAogP46Wevsi/C85lFdWFHhDj4dOFccaEr5s4+YITFwxW1AUQ7DBpPr0kWe1oLZTWk8pp/Ov6vipREbo8HddLibxRzlenk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768759392; c=relaxed/simple;
	bh=xYh/MGaprulPNWNckX8ng3qqlquYOGwnkkCr2j/CcxI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oovlzLhsnb47HLpfQ3J/z8HFQ0kowz1j89jDqQKGf15utg31bkgEV/gSiUtixlhgke5n1vYZyYYY7wjOO4/OJ2WQa+F3qhbrizIaVl5TVmKvikV5cJQhlg5PaLsmnPravexhmHEJYnds2LNKoPzi0rn/wcY99Vi+aEMFa8x6+fY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fF4nwr89; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fF4nwr89"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F710C19425;
	Sun, 18 Jan 2026 18:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768759392;
	bh=xYh/MGaprulPNWNckX8ng3qqlquYOGwnkkCr2j/CcxI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fF4nwr89OKAuUIN3mG1fkkDWDB5TKShvMFkqun5REmQjGP9UF46WnzFMcFDo6PlzG
	 UNTds1GHE2O+QypTxIbRTb8DC8D2RAb1tk/W3BnGyZuCC8JKVLYQx4sXfgYVyxYkeu
	 SEhkr+G16cNxUTT6eW/NfCye+8yZdGTEhUuQrjvvt3eQ6UQrJ/AH243W1Ebd3HYXwH
	 ly9seughSUdCihmUS0J+8xsTBbpf57CbSg1xl3ay3OpgIfPzWLZAWavdeAidWlngLi
	 WK5IIZ/RaCtKOnNod0QlDFm1TFHYO47JOqvB4xfz5oAvogUQYtnwg9kU9h5i+FweWH
	 hYMCfaIghU+YA==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	David Hildenbrand <david@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	damon@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 3/8] Docs/mm/damon/design: document DAMON sample modules
Date: Sun, 18 Jan 2026 10:02:54 -0800
Message-ID: <20260118180305.70023-4-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260118180305.70023-1-sj@kernel.org>
References: <20260118180305.70023-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

People sometimes get confused about the purposes of DAMON
special-purpose modules and sample modules.  Clarify those on the design
document by adding a section describing their existence and purposes.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/mm/damon/design.rst | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
index f3db943d7efc..da0bc40c2261 100644
--- a/Documentation/mm/damon/design.rst
+++ b/Documentation/mm/damon/design.rst
@@ -836,3 +836,16 @@ modules for proactive reclamation and LRU lists manipulation are provided.  For
 more detail, please read the usage documents for those
 (:doc:`/admin-guide/mm/damon/reclaim` and
 :doc:`/admin-guide/mm/damon/lru_sort`).
+
+
+Sample DAMON Modules
+--------------------
+
+DAMON modules that provides example DAMON kernel API usages.
+
+kernel programmers can build their own special or general purpose DAMON modules
+using DAMON kernel API.  To help them easily understand how DAMON kernel API
+can be used, a few sample modules are provided under ``samples/damon/`` of the
+linux source tree.  Please note that these modules are not developed for being
+used on real products, but only for showing how DAMON kernel API can be used in
+simple ways.
-- 
2.47.3
