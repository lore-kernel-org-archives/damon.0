Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 017F81B7910;
	Fri, 10 Jul 2026 00:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783643047; cv=none; b=QRY+Zs/ojrXk0Zv9e/n0j3wn39iaj8aiLMx+mbS4GhL6pWoEvFoz9BpYWehQgb9gVXyhNTo6S5ARz79Y2oER5NXozRs6kY9O5iPQiolvnXPoLtgXYc/P0pwxU4cEgjDKzlNZn+dxlkthPVEj7Bu+k7EWh2bUYg3Kl8ZqmDAJE2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783643047; c=relaxed/simple;
	bh=76Ms7lr2E1n8a9s5BVP9BtK3Clv9+dktfC0KcnJw1zo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CjNBqyeeeFwYtLlrCmn4zvXPfx+TS1WDePwsXVbJX83QweC++MIKbbizV2lQsXMWB9tdIzlR543I9ShEsdSg1+pfEmGj5Y1sBYK7hA6i/ESvSSbLC7CiUwuvtjLaPMb15arHqk5XU96bf9enZ2IIgDKxLpgjXlz6U858HOmt8Sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mxxrle2H; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mxxrle2H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 752501F00A3F;
	Fri, 10 Jul 2026 00:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783643045;
	bh=KtGhb2uuQghnzvwRekFMe5vHCrkMdKOrMY5ghfXYhj4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Mxxrle2HvKS7gPM1xjtDR48y4rnwwtoL5k7Kqnb+nrAaDAG2FD4Kzr2MGSEhVxpGD
	 OfzmAYqqxtZNfzgQRVHYCKFbsEA8HZRcTw7AEMfK3tweyRcfmtgCxjcvWoowrm+pD1
	 xakuMBt0o94PcDcqPwAQdlKinQcTl8lkzjTPTf/ZaxTDwnZe4G0p3e1WopFvivpvnR
	 jBpb8sZicPBNZd8xKuDc2Mshk0sCipbLAdhla/ZQiFAoM4L2JWSujQocheu92z422s
	 hPmte4WlziAx4/s6v1VndaR77o8U/V/WKKMHSKpbPvEQoxHu+a+Rd+nj8DLesvCFmq
	 YKwkvLswzh+ag==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.3 19/19] Docs/ABI/damon: document probe weight file
Date: Thu,  9 Jul 2026 17:23:45 -0700
Message-ID: <20260710002349.111414-20-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260710002349.111414-1-sj@kernel.org>
References: <20260710002349.111414-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update DAMON ABI document for the newly added probe weight sysfs file.

Signed-off-by: SJ Park <sj@kernel.org>
---
 Documentation/ABI/testing/sysfs-kernel-mm-damon | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-damon b/Documentation/ABI/testing/sysfs-kernel-mm-damon
index dd6b5bd76e119..907a504fb64c5 100644
--- a/Documentation/ABI/testing/sysfs-kernel-mm-damon
+++ b/Documentation/ABI/testing/sysfs-kernel-mm-damon
@@ -164,6 +164,12 @@ Description:	Writing a number 'N' to this file creates the number of
 		directories for each DAMON probe named '0' to 'N-1' under the
 		probes/ directory.
 
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/monitoring_attrs/probes/<P>/weight
+Date:		Jul 2026
+Contact:	SJ Park <sj@kernel.org>
+Description:	Writing to and reading from this file sets and gets the
+		per-probe attribute weight.
+
 What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/monitoring_attrs/probes/<P>/filters/nr_filters
 Date:		May 2026
 Contact:	SJ Park <sj@kernel.org>
-- 
2.47.3
