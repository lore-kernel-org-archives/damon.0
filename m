Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A8D643C7D3;
	Tue,  1 Sep 2026 04:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788237273; cv=none; b=AFZN2uEM5hpqRf2sJVbBFTjM++07HbxM6EI1S8DiJSi15MCaAIylK2v5lqDmNGsOU6I3qfs/kzUt4PAOEUdEPjdm4NmjHQOhp+Mc3cU/sXM7v8VmmexVsIVw2oHMV4Nia8WNikwxqaU58vJp4gxU5OFktSaJn3vVJcrlu5cDk+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788237273; c=relaxed/simple;
	bh=Pffw0QddcOdszpO6Pf+uRui7oVwqUV9y0L1CM1LEgZM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PDoDL4FCqjVUED0Q7fuuFXaqEY4d9do+Bgp68rYVBZHLR5JYG7zJNtw4Irarnk4E6vgc7jdjS5b24eZyDyKRpUy1ExjrifB+DF+PJe2exgdm4ctnce3Wal8SphgkvJAy6KdBkmGA2GDMqJwrxLLYf1y4cm5nFhtDVGR1/MyEsAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KYef/bpG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KYef/bpG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E78F81F00A3D;
	Tue,  1 Sep 2026 04:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788237272;
	bh=Zxj0qXZlLFjv8Oo1ubEI7gb1ZBWWHlkx56zIdj50cXg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KYef/bpGHdth5P4hpCVs8AlrupN3bO+g/Ct0O+xni8mx5I4W4aahUiVZOSvaeGt5P
	 hFQr4fppHSKmAviFXy3GEKD9F2/WlLSse2r99DeEt3jwhJRPXwqjk71puz7Zm6A1p8
	 1csdIYo6QqE5ct8u+ONiCVPaio6JQERUgSb1EGHaIOaBApezvGSDrF1CAp41wmxpzL
	 kiku/sCeJaebyCTbU5DDEjxJllIO0lHjfTQwmHe170oOIzdm6RKYlvdyIxrdvC+26+
	 WiZGwNs1kKYsBOBytH2hvAupF53+GeWUzC3SJm/vGmoS4GGcZqOMTbxLvfo8MAuBbm
	 0ZFv0izsEPekA==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 17/17] Docs/ABI/damon: document probe prep sysfs files
Date: Mon, 31 Aug 2026 21:34:13 -0700
Message-ID: <20260901043417.2165-18-sj@kernel.org>
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

Update DAMON ABI document for the newly added DAMON probe prep sysfs
files.

Signed-off-by: SJ Park <sj@kernel.org>
---
 Documentation/ABI/testing/sysfs-kernel-mm-damon | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-damon b/Documentation/ABI/testing/sysfs-kernel-mm-damon
index e675a57145e36..f8d2601e82904 100644
--- a/Documentation/ABI/testing/sysfs-kernel-mm-damon
+++ b/Documentation/ABI/testing/sysfs-kernel-mm-damon
@@ -173,6 +173,19 @@ Contact:	SJ Park <sj@kernel.org>
 Description:	Writing to and reading from this file sets and gets the
 		per-probe attribute weight.
 
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/monitoring_attrs/probes/<P>/preps/nr_preps
+Date:		Jun 2026
+Contact:	SJ Park <sj@kernel.org>
+Description:	Writing a number 'N' to this file creates the number of
+		directories for each DAMON probing preparation action named '0'
+		to 'N-1' under the preps/ directory.
+
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/monitoring_attrs/probes/<P>/preps/<R>/prep_action
+Date:		Jun 2026
+Contact:	SJ Park <sj@kernel.org>
+Description:	Writing to and reading from this file sets and gets the probing
+		preparation action.
+
 What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/monitoring_attrs/probes/<P>/filters/nr_filters
 Date:		May 2026
 Contact:	SJ Park <sj@kernel.org>
-- 
2.47.3
