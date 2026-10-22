Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.7
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792681469;
	b=VZHOVC1BHc4sNHhp8pu0OHgz+62dAElnxdWVmc0IyNsHfE5jhKpVb1n+3/YoMj8FkgUi
	 p3IL4d1XVf//X1cM8/AS58wVVRaJ0UqVypoh1+D5I0ZQT7qEiD9A3ujbsFkOubG9OyUFr
	 7TYBcmgN3IsIHuWAJuheL88CIb5SEpb8Q7FqpBGrVnlKFlMRf606E9Wqmh3c6ElKmYbqk
	 R2b9zUh225lof+DpjLrlHLacA0VF4vCLEsTfS0kBLL4eMGg/fQ9pqNWP6yPphjn+G/d90
	 Uwk7GFWehWBbo71YrrULjDoMWNzy3ttJL7v35KOiXRnTsVOLxIFZmOnPnIqhQITwoBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792681469;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Date:Message-ID:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=zKV5mVym2fjfNhUm4DLdJcnKPJbD3s5y+KWCBn/6kOQ=;
	b=IiOLyGbZdYLfmf7ZWvgx31AXJFp3hkfknXMMef3MHZioX22VYXg/WWdBnMEq2x8x+ED6
	 5hQLhgA3yKJu4b+Li5EUR/LYpHvqLMiOrwVQgrc64QNsIalGiE5XuXlLfGhy48PORNfEK
	 xrWrxBtsSxEAEJDi0iFqRuPIkSiQ0me9bdht/FFPYtd5Y6l8Rv/Fuxi543M74uGn7l+aK
	 keT7dAVwxI4OgZQ8ABEvsr+G8TlpD63A2G2T8qjjROq/t0BmE5iYhfZRiS1cbojX2lmY7
	 6cXsh+Q3fBHsk32uYCYh9rDoB0Bj5Y6zdz9ueiRVZdBjr5rBVMDeQIshe9sy59OnByw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=UKRtIlqj;
	arc=none smtp.remote-ip=74.125.229.7
Received: from mail-dy2-f7.google.com (mail-dy2-f7.google.com [74.125.229.7])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC14606A331
	for <damon@lists.linux.dev>; Thu, 22 Oct 2026 15:04:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2DC14606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=UKRtIlqj
Received: by mail-dy2-f7.google.com with SMTP id 5a478bee46e88-36758ba1f01so921182eec.1
        for <damon@lists.linux.dev>; Thu, 22 Oct 2026 08:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792681468; x=1793286268; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:subject
         :message-id:date:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=zKV5mVym2fjfNhUm4DLdJcnKPJbD3s5y+KWCBn/6kOQ=;
        b=UKRtIlqj2ws/we2VXPq3KkqV0ZmnE09+cUbFUzhmHcQc0jC0xwfuY5pqboEgMzcSI0
         KzrejSKLoXxopQ2WcWb12CZ0lKkWtJZTKFobDmORshvxzWu7GQiiQ91oBNzatLXGpVT0
         uxN/tvtgXah3Jz07tJtwthim30q2Eedb2YZ191y4qFhkGda2/+YL0i3IcLP1nhOATAmw
         MkWnSvQl9cy4GaqEEYd7mYwmVJ075IA0ZdsIBwWu6Vl9EyrCKDNwxy5aP5BeD0E4dphB
         AWgSawiAczZo4ENvy4i1o23n+EJbFFr1QIjLmjDkO6Jk+9v0fBWrL8w43REB/f6+L+mz
         3vQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792681468; x=1793286268;
        h=content-transfer-encoding:content-type:mime-version:subject
         :message-id:date:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=zKV5mVym2fjfNhUm4DLdJcnKPJbD3s5y+KWCBn/6kOQ=;
        b=pBlW6xKmVPORISDH3VP7gz2ACEUrzfRD1pBppbTlYmnY8+m/8Q3fUUaK5cx65+NSIq
         lf8izbLvCxsoTYtAvCX2UCriea7xcPPwwc6UuJEYMBP+bBUvGbhPkbiUiz6brNjEi1We
         RHiIdsQHAS0EF1pYUaHpPH6J9Law8dXC5oJKsWycCRW0DU6+LxM4zx5am9xFovdPTeyE
         zo35H/VbJyaADSo4QWSVOsDfKiq2icBt8I2SlWHRYDlok6bHiiRgxPwG+1uCEbKqwmHu
         52Nrpw8XYRGf5a6NCVhX7ufZ5Zr0Zqbeu3gRSxzwAWiedpKJjAb7auAomAKwvOrKVfmI
         kcGw==
X-Forwarded-Encrypted: i=1; AKwUvByxEjXA3c410QxqsTO/Ox6Nmy0F673hNPB7d9x4T6u/wKwv0vETMZVTKDgLssERlKcsxwa+3w==@lists.linux.dev
X-Gm-Message-State: AFq9FYJKGkS56wMSt0yH+eHL1Nyk0nZrj6HE6FaIbCmksjVYVokT5TJ1
	nJ7EXwA5+X70kEyQEi+oVaKFfFnPaYIw9x0xsssCc5NjzexlHgihPMCD
X-Gm-Gg: AYBFou2ZOTDfQWxSYBigmotabBDdCzC6t55COGQCHZLEKLq/OQwT1UXbW7asZFD/ka0
	MWJACeYEYHsepZbARnumk7bssim4E/xhjRRmDQsYyr6jlAyb+DwcecI5jzBxiBpxdQfM7mMoKvn
	MqmuJc6Apb+khmd6osuElW/f85c3jK8iDMe13lreub+JGgMSwOw+Qi/hLPyp6ER3vrEdyKlOEBL
	WvPrFm9AVrJB3lVy0DLGcvPzumpP1fBbVdEvy0sNF7gvXKYVmCX+vTfjJq8GieqyF9Xb8ekKgC0
	qjxAgvPD+ToCRbr1a1UVVdKVN8nuzF0Jvs0Jfx+TxwIKhIJde5rz7FykJReYe5/g/SOD9zj05SO
	klyMINJOuKboZ8n7YQ5VFircgHfrN7ltYnOL8OtAOcLdzhOgXNDHOAM5Ps29K7gtpWkvxZLPmh+
	/iLwE+jwAy+fFOfX4uJcTd7tVPjYUfpIEH2SpfCulwn118qm6Ki2PMhfrD/qSWEK1Gwml0ODRM+
	9q3yJ4NUZJz87tQHrUwRPK3Xncwygz+Zmauyh2j1nKjuoNYqQdXtzHGSEA+09kkpmwuMWLGmXO9
	gbCOJMpJFRTE91RRN741x30ExEvGuuYjK/L3CJNSZALCwHq7VWWmHg==
X-Received: by 2002:a05:701b:2313:b0:148:722b:7cbc with SMTP id a92af1059eb24-190a55c1a5bmr6422063c88.14.1792681467862;
        Thu, 22 Oct 2026 08:04:27 -0700 (PDT)
Received: from localhost (n106-71-19-159.sun21.vic.optusnet.com.au. [106.71.19.159])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1903a180ca2sm13886422c88.6.2026.10.22.08.04.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 08:04:27 -0700 (PDT)
From: Aveline Noir <jm5905938@gmail.com>
To: SJ Park <sj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Shubhang Kaushik (Ampere) <sh@gentwo.org>, damon@lists.linux.dev,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
Date: Thu, 22 Oct 2026 22:26:08 +0800
Message-ID:
 <179267916870.2.5637290691657871645.damon-pmd-align-draft@gmail.com>
Subject:
 [PATCH] mm/damon: align MMU notifier range when clearing PMD young bit
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

damon_pmdp_mkold() clears the young bit of a PMD but notifies
[addr, addr + HPAGE_PMD_SIZE), where addr can be an unaligned sampling
address. This can miss part of the sampled huge page and age secondary
mappings in the next one.

Align addr to HPAGE_PMD_MASK so both operations cover the same huge page.

Fixes: 3f49584b262c ("mm/damon: implement primitives for the virtual memory address spaces")
Link: https://lore.kernel.org/r/20261021-damon-align-pte-young-notifier-v1-1-d0365ac45b66@gentwo.org/
Signed-off-by: Aveline Noir <jm5905938@gmail.com>
---
Tested both aligned and unaligned addresses on 2 MiB THPs in an x86-64 KVM
guest with a recording MMU notifier; all ranges matched the sampled PMD.
DAMON KUnit: 37 passed; selftests: 13 passed, 2 skipped.


 mm/damon/ops-common.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/damon/ops-common.c b/mm/damon/ops-common.c
index 8fc61d0..3b7519b 100644
--- a/mm/damon/ops-common.c
+++ b/mm/damon/ops-common.c
@@ -83,6 +83,8 @@ void damon_pmdp_mkold(pmd_t *pmd, struct vm_area_struct *vma, unsigned long addr
 	bool young = false;
 	unsigned long pfn;
 
+	addr &= HPAGE_PMD_MASK;
+
 	if (likely(pmd_present(pmdval)))
 		pfn = pmd_pfn(pmdval);
 	else
-- 
2.56.0
