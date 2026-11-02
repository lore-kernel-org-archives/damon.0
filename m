Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793632087;
	b=LUqE82osmDoq4zH4d0NyXxCwtL/TpMbkQNg/LUPo3ZJGD1/ybUw3tJCvO5yl7EWQ4v8g
	 QSYHZwHeERKduiS4zpABMv81blWOCbqHTbhpT0COCcLnI6HjNikkcTktLPtVNig5T4PMT
	 ySyp84/D88tQVc0yNZW8iv5JrmbGAkMtTTl1XnaxZdQG9Q1yc6P8fbtK43FcKTh/8GG2T
	 AQS4fLkfCSHypB5HP7yb7HNje6Vqw4W0Gk+C6Z7AHpQqOOVslweL+gVAGEiA6gj3/impu
	 mP8DyncwDQs9rCoZiNuFefCPWtQAh6ueIKe57Mlm+QGq2GItnycfoLdwKn4uRT2KS8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793632087;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=6b6oFi/epwMKMYOCvMcLX5SixjsFrg88HIyGcM89GbU=;
	b=PlTJliYTtl4oXEv4dpZe/9xrTBZyln+9mSuEaKgRZcLkaD8EoZODboMANkrOgjjLSUXH
	 cRVwi0SJ0HerBLQEymDD6SI8+aphFst9QvyCfqTMTxWIm/LAupOSOkn18mO9lHckS/vX3
	 icQo0YFEGh5EXwosDsKutqPbXwXtWufg3YTTAMAh1FEvvK5AwY9VH1Wtpl5qbeh6Irqv1
	 /L5S6p5P6ajkPgg7cNokJ7VDlgE+SHd5qcrldl6DyAQTzzg//lJf2+N1BeOK3Im8gh7Ki
	 Kk6JJiC3OG5Yvmosy4D3KwxYfeJ7H1DFOiw3eXEKWxUkppRpSxtkYUuxqLYJ1LeYGaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XrZQnn4C;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9233E60A0FEF;
	Mon,  2 Nov 2026 15:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XrZQnn4C
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17A241F00A2A;
	Mon,  2 Nov 2026 15:08:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793632086;
	bh=6b6oFi/epwMKMYOCvMcLX5SixjsFrg88HIyGcM89GbU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XrZQnn4CsywSn7qcJI5WSFd6QsTFCkiSXKgVSrtcHW7w3BEPDx2Ei2g0dIeCyp/ho
	 IELSsBOsA8xgkDWQFCYeCfw/LMll3OC63RXdWKfROfoZiFSISwpziClYJ6Aw3p/2+S
	 WbH8KnZWq21CEEu9lwvPaL3X1rm/odickrCYAjwXWggL7LQ2G4l+gVJSU+aagHAnHf
	 fS+e+YShp6GqAAMioEpvJMbOOkjDMCL5lJU/cfxkdiUbSHkjm1yKeXDESlp0fJMfht
	 iSG23szz+J/DgIdXs8WA/oxAW9kQJfVI1Asn/Vq8H4BGIaKmQGVpSeIQwRK4sFO8y6
	 RCpEUe885QO8w==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Aveline Noir <jm5905938@gmail.com>,
	Fernand Sieber <sieberf@amazon.com>,
	Leonard Foerster <foersleo@amazon.de>,
	SJ Park <sj@kernel.org>,
	SeongJae Park <sjpark@amazon.de>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Shubhang Kaushik <sh@gentwo.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 3/9] mm/damon/ops-common: align MMU notifier range when clearing PMD young bit
Date: Mon,  2 Nov 2026 07:07:50 -0800
Message-ID: <20261102150757.93058-4-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261102150757.93058-1-sj@kernel.org>
References: <20261102150757.93058-1-sj@kernel.org>
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Aveline Noir <jm5905938@gmail.com>

damon_pmdp_mkold() clears the young bit of a PMD but notifies
[addr, addr + HPAGE_PMD_SIZE), where addr can be an unaligned sampling
address. This can miss part of the sampled huge page and age secondary
mappings in the next one.

Align addr to HPAGE_PMD_MASK so both operations cover the same huge page.

Fixes: 3f49584b262c ("mm/damon: implement primitives for the virtual memory address spaces")
Cc: Shubhang Kaushik (Ampere) <sh@gentwo.org>
Signed-off-by: Aveline Noir <jm5905938@gmail.com>
Reviewed-by: SJ Park <sj@kernel.org>
Signed-off-by: SJ Park <sj@kernel.org>
---
Changes from v1
- v1: https://lore.kernel.org/r/20261021-damon-align-pte-young-notifier-v1-1-d0365ac45b66@gentwo.org/
- Drop Link: tag.
- Collect R-b: from SJ.
- Update subject prefix.
- Rebase to latest mm-new.

 mm/damon/ops-common.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/damon/ops-common.c b/mm/damon/ops-common.c
index f88c6fd189fca..b9571f53e538c 100644
--- a/mm/damon/ops-common.c
+++ b/mm/damon/ops-common.c
@@ -102,6 +102,8 @@ void damon_pmdp_mkold(pmd_t *pmd, struct vm_area_struct *vma, unsigned long addr
 	bool young = false;
 	unsigned long pfn;
 
+	addr &= HPAGE_PMD_MASK;
+
 	if (likely(pmd_present(pmdval)))
 		pfn = pmd_pfn(pmdval);
 	else
-- 
2.47.3
