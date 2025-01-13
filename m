Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E2261B87EC
	for <damon@lists.linux.dev>; Mon, 13 Jan 2025 18:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736791437; cv=none; b=BxG3pFYxRsHYrjWTlxwA1HW7ekrSBTuqJH35xMEfRA21TuV7xlMCIdnTAQ3PP1XyoWRoObgl2w5acFcUYzIvcfGHv+nMS+FvaX6A8q8KQM00YOjkNoXRYGfJwezWVhUwjek3n8VI5ZjYrdpfgyPPlCIh/cKW0I37F7e7agi67k4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736791437; c=relaxed/simple;
	bh=i+H7mdpE6FbGbHZwvwIlm/6U4EH2b60WQbpVNCDdnw4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=i25MODBK9fbV0f0OCtzSFUR7VjNmpSSNrqStTRirUclktaS3chPCR5Fhvvw1p6U8HHrwEqG4Lm+5BfkNOmJfct6ImmBoZ5O1b4ldxZsUTJlDvxsdc+HfJ0JT2n8knrwrla79P7hjbZdoyNOZUoZTC9AYJuNgdTv5vP9sm/H/GLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=muKKN/Wl; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="muKKN/Wl"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-46901d01355so45684091cf.0
        for <damon@lists.linux.dev>; Mon, 13 Jan 2025 10:03:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736791435; x=1737396235; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aSerPn266Pb3Ey93gnhZWD46Qo6xjfiDgChx6SZ4WyA=;
        b=muKKN/Wl+qI9Tut85CaYUh5fP6uyKv0SJU1gLx6USYGVWYmicjd2qR/0Mis5K7lG9o
         TcDk5yc/mkxOCRGfp+sQipC2Oog6KfurVRCrfqc5RlZ5FTGqImnQ4WB6vkx1a2Kx3+at
         d0uFLRD5tdFzLc1xTC42XUVFH9JLocdxsT45ETnqyc7B7cuC7juvIFZ/tycFWHI5wlMF
         OLi/AC1eE/v1ydET4i6A+HS96vk8vFkAInHDVMYyqVZgrGelW7QwhDT6nCqBTGHAhhB8
         7QfVSAycsW0IJlNwNK+034ZgFgZmB/i9DnimYXrWAdVItUCpO1VTKceBPu9GwaqxvhoE
         xDtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736791435; x=1737396235;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aSerPn266Pb3Ey93gnhZWD46Qo6xjfiDgChx6SZ4WyA=;
        b=LEcE8K06QviaF09M47m1OGg3XkNwJg6MNcp+gBA4yvxr5idSooXDRVs7UfnDhQwRDZ
         QUVhD6CiHszQ+FeOS1ucUNTp+qWe/V5aMHwaScy2vydW6s6+bpC6QgBd+56ReRJMLZcq
         cGcUzCr6C+3ytIzJnFX4XI/i5kVBTujVpnah9pnCgcs/p1rWOSBPM7rCl06W01pJdkTP
         +rLoCDJMJ/UxK7lLgY86PqWam4FygtHzqFVGhMWxecYB5lUBPCnfltLJ6Bett8pD8iLN
         YFluXw9193R/faxX24/dJg/CaKNOOVQvTBaqh0oUsFL+JUhcUc2nS91md0bJfAj97OeU
         gKWw==
X-Gm-Message-State: AOJu0YwDUefJUTfTLbTLf3xuPyLdrqfdjXrYznHVAnk1WV5Im2RJ92BK
	L2NRlL3I+x/MiUnvLgQmBDBXnQDnbZ8NCb5Zp+q0acrjTG1BiNYZxOIxOw==
X-Gm-Gg: ASbGncsWE4BjwfUnqAXgLsPreCRlMcVBRrq0rs90DgPaDYFTQrOMC/AUV3hNoUEny1k
	knoGvuHRbXvXXjyszfN6nL6S+KwhwHCV3zHMbw4eETSpP97Z3PMEmpl0LTQP5u3B1ENMBj+0cR4
	SqRSI2Is5sdDtv7Zp/h+BQgjebDhWb+2KmtqyWzM8RYzelpNlwW6SyGxlYeRIAM7D6sPPAX8cNB
	727VXTyIK3K9NFxsUedIZQplr1K63rsOee6YSZ7F+GjQmGtUKDFSCE=
X-Google-Smtp-Source: AGHT+IEAvK+Z7LvnMbeSsClwbqmr2qInUEGlPcAKR2aK81e8XpgPsiIvLB4dQLAMPG5WhZXcmW8r/Q==
X-Received: by 2002:a05:622a:4c0c:b0:46c:74a2:3492 with SMTP id d75a77b69052e-46c74a236demr354624961cf.41.1736791435224;
        Mon, 13 Jan 2025 10:03:55 -0800 (PST)
Received: from localhost ([2a03:2880:20ff:4f::])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46c873cddfesm43432561cf.57.2025.01.13.10.03.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 10:03:54 -0800 (PST)
From: Usama Arif <usamaarif642@gmail.com>
To: sj@kernel.org,
	akpm@linux-foundation.org
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	Usama Arif <usamaarif642@gmail.com>
Subject: [PATCH] mm/damon: increment pa_stat damon address range by folio size
Date: Mon, 13 Jan 2025 18:03:40 +0000
Message-ID: <20250113180340.805474-1-usamaarif642@gmail.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is to take into account for folios with size > 1 page.
Iterating at PAGE_SIZE increment would increment sz_filter_passed
multiple times for the same folio by folio_size, providing incorrect
stats. Hence go through the folio only once.

Fixes: 6347f3385dd0 ("mm/damon/paddr: report filter-passed bytes back for DAMOS_STAT action")
Signed-off-by: Usama Arif <usamaarif642@gmail.com>
---
 mm/damon/paddr.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index 6b4397de4199..cc789a97c6f5 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -504,7 +504,8 @@ static unsigned long damon_pa_stat(struct damon_region *r, struct damos *s,
 	if (!damon_pa_scheme_has_filter(s))
 		return 0;
 
-	for (addr = r->ar.start; addr < r->ar.end; addr += PAGE_SIZE) {
+	addr = r->ar.start;
+	while (addr < r->ar.end) {
 		struct folio *folio = damon_get_folio(PHYS_PFN(addr));
 
 		if (!folio)
@@ -515,6 +516,7 @@ static unsigned long damon_pa_stat(struct damon_region *r, struct damos *s,
 		else
 			*sz_filter_passed += folio_size(folio);
 put_folio:
+		addr += folio_size(folio);
 		folio_put(folio);
 	}
 	return 0;
-- 
2.43.5

