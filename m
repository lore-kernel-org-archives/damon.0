Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 104AA78F2B
	for <damon@lists.linux.dev>; Sun,  7 Jun 2026 13:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780840139; cv=none; b=VHV0Qo99QUWhVEzq9GUvlmMDKEtyu8YaQnMk+SZ58aGsuwzTEuB9IsXACK6bFYSXJTJk8C03fNDYJjzfBLc9URO2ZU2VVvuzCWeZmVXirlBpIcXAA0CRlMy8u12wdLH4eFwv8SLMpfu+jBa2pr0KrMa/9GbMf8r5NjcEaF54Chc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780840139; c=relaxed/simple;
	bh=Cvgq6hNpp3pN4v1ssOQj4C8t60KcXC1VRT5noQtt7FQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Bx3jgb0ReH1vpiYGFGNxK0bVJqH4y8caJsxuD2TMET4QqPqsT+hRqReSggh+ZIDaogehfBXuXHMK3gLIy54qwqO+U0hVhNdj79wvyxz7UMi+kkWUarOUAEFZW6XBKWZgrtAhGHdfzqT9LUu1u3g8CjW/8TPjyzta0Xp3jNUtJx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B+yBehLJ; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B+yBehLJ"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-8423f869421so2608818b3a.3
        for <damon@lists.linux.dev>; Sun, 07 Jun 2026 06:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780840137; x=1781444937; darn=lists.linux.dev;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0CTxO7Hcxcsa+DE7y8PeV+aprK4GKwNhOSFfFn9fnPw=;
        b=B+yBehLJWLT9iJk8nY2hlEiF03SrYC929mbALFybmycRCFGMhX0binjSF4+x/4jh5s
         yQoBzOb1wxjFtcCzrIPkWUusLlP9i7+JW7YpfmXSJI8LRp2cMjGsuOEyp0yAAC3R4+AK
         Lq1Sr/9S4XDz6LUcMi8ypLSlzFQxXPDz9vq1nWbsAF2X4UOkMVoOfIxODs6y6ZBWePiA
         lwWvz6GNV0l/SNBur3j04UQ54ZfGgglwNWePDKKPb3HBgKkGFzZ1ntqQkdPkUB8qNXNN
         z3jaxMidhUQbOFWv1SCi8ITt4woiPvSuEeHTeHdoh0t0WMywi4AzgP5Q+XL0tPssJ6ip
         07oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780840137; x=1781444937;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0CTxO7Hcxcsa+DE7y8PeV+aprK4GKwNhOSFfFn9fnPw=;
        b=BipdFTejL98mFUBbsyVODrb+2j1bZdiM1SniV+6UfDaf/m8lEDpELTJhI2E4GUsm/v
         5hkFijKKLHWWMiR4MbdS2SOcsS6MwOQ5RBqv1pcjPM3Y93i4n0Cae98QGUmiZvvvVjVJ
         QJ+562JZve12goalRl4Fy9PHmFwB0kuK/O860NKqiMiHuOqyRfM44FU9HY4AoDh2szA1
         NuuTl9H/JTq/hUBuSSODt1IhzboTyf3bfxc61gMWCSW4qjb87md1StyOi6JRGPzjq2VM
         UC7zPOvnfbIZ/BF+b22PNvy0GWjuNipqWwonAA97qk8dgJauc9N6ot7t+9AuyhIR8GKt
         J0KA==
X-Gm-Message-State: AOJu0Yx0U6xS/JmYfuXBDggl2FlSP5JmyXZRydiGrlT7YhA/5szncI14
	FwK5U32VO3fPeXCZW+B9XsJpPZSoz8aSTxD53kI5U9Y4vYtqVpdEG2H2
X-Gm-Gg: Acq92OGAtXygQAZtNbyBkuimiKFUqwDTRG0LgvrJVkMvfDY8dkoJTPctp5Wbh68Krl0
	ktN6JkNuSVjAU68LaY8/lOjBWpxlU9XT4Ely4kM/JRtYpH0fk6zHxRRn7eMcUO16B4btNqS5ZKc
	HoxzDviJpIgy0XavWaupPQN4y5FugqfzQDAfKA+4XFvpY5AjJ1mEpjP+iqF7vD4eEff7AoNf9a7
	f4ZN8qnTCrVSVkKTGO2ggPllrkz2RRzjOJhg8dNIwTHZl3744D9gBc9TIPpXn/ymQhyWQAhdfUx
	AN+mrzT7F+i0tCtZ6dnDjaPzlRhGibWwdcg7R5qxPgiNMkpbZjhcNERYxzW9/kVmfFObgAMiqdc
	048zBYEwrwQnuMMhHBISQeBKSqKBld90N6xsoqRhYGlzikl1z86E85MlmG67xVtNNLaKUkHaXv0
	17pETpgeUdBJzfD4PaqrxX3cz5ar4m15TO0Q==
X-Received: by 2002:a05:6a00:234a:b0:842:7221:dbb8 with SMTP id d2e1a72fcca58-842b0e57474mr10850926b3a.15.1780840137253;
        Sun, 07 Jun 2026 06:48:57 -0700 (PDT)
Received: from [127.0.0.1] ([116.80.91.208])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84282918b8csm14365235b3a.57.2026.06.07.06.48.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2026 06:48:56 -0700 (PDT)
From: Cunlong Li <shenxiaogll@gmail.com>
Date: Sun, 07 Jun 2026 21:48:52 +0800
Subject: [PATCH] mm/damon/vaddr: drop redundant mmap_read_lock from
 damon_va_three_regions
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260607-rcu-v1-1-3c9f5995a3a0@gmail.com>
X-B4-Tracking: v=1; b=H4sIAMN2JWoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDMwNz3aLkUl0jkyRjI5NUgzQDczMloMqCotS0zAqwKdGxtbUAK8Q7fFU
 AAAA=
X-Change-ID: 20260607-rcu-24b324e0f076
To: SeongJae Park <sj@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>
Cc: damon@lists.linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 Cunlong Li <shenxiaogll@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780840135; l=1761;
 i=shenxiaogll@gmail.com; s=20260517; h=from:subject:message-id;
 bh=Cvgq6hNpp3pN4v1ssOQj4C8t60KcXC1VRT5noQtt7FQ=;
 b=PejStRa7IarY8QPXkGy/Nf155AyVFmcMEsGQmhZELK5FxMOFhB4kAhKN2VHYFQy/+DFy14J/h
 Ao3Po6T9PcuAN5TahK0z1kybF+HmDYUawk7HaxWMBHIsKnPC8I8s9P/
X-Developer-Key: i=shenxiaogll@gmail.com; a=ed25519;
 pk=SKFifnqPdsvsjuhUiq+Y9vtCdhyZ/LrRcfYn8eRq6AE=

__damon_va_three_regions() already walks VMAs under rcu_read_lock(), so
the outer mmap_read_lock() is no longer needed.

---
Signed-off-by: Cunlong Li <shenxiaogll@gmail.com>
---
 mm/damon/vaddr.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index b069dbc7e3d2..27e34596c43b 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -77,7 +77,7 @@ static int __damon_va_three_regions(struct mm_struct *mm,
 	struct damon_addr_range first_gap = {0}, second_gap = {0};
 	VMA_ITERATOR(vmi, mm, 0);
 	struct vm_area_struct *vma, *prev = NULL;
-	unsigned long start;
+	unsigned long start = 0, last_vma_end = 0;
 
 	/*
 	 * Find the two biggest gaps so that first_gap > second_gap > others.
@@ -104,6 +104,7 @@ static int __damon_va_three_regions(struct mm_struct *mm,
 		}
 next:
 		prev = vma;
+		last_vma_end = vma->vm_end;
 	}
 	rcu_read_unlock();
 
@@ -120,7 +121,7 @@ static int __damon_va_three_regions(struct mm_struct *mm,
 	regions[1].start = ALIGN(first_gap.end, DAMON_MIN_REGION_SZ);
 	regions[1].end = ALIGN(second_gap.start, DAMON_MIN_REGION_SZ);
 	regions[2].start = ALIGN(second_gap.end, DAMON_MIN_REGION_SZ);
-	regions[2].end = ALIGN(prev->vm_end, DAMON_MIN_REGION_SZ);
+	regions[2].end = ALIGN(last_vma_end, DAMON_MIN_REGION_SZ);
 
 	return 0;
 }
@@ -140,9 +141,7 @@ static int damon_va_three_regions(struct damon_target *t,
 	if (!mm)
 		return -EINVAL;
 
-	mmap_read_lock(mm);
 	rc = __damon_va_three_regions(mm, regions);
-	mmap_read_unlock(mm);
 
 	mmput(mm);
 	return rc;

---
base-commit: 8e65320d91cdc3b241d4b94855c88459b91abf66
change-id: 20260607-rcu-24b324e0f076

Best regards,
-- 
Cunlong Li <shenxiaogll@gmail.com>

