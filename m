Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.134
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794897119;
	b=pzUK9lN9FSHBMQdCRKRQSVmE+phdeS5FZr+MWxaqTpM1dGog0qnEp5kmnrMIcfUDEDKG
	 hWu8R6PJXzVHAR0s9BzaveGxoRvBPxLhtM+Xg3wh/IZG0aHgi4ZL0+8R9NXCjaDM0tDEv
	 3bWgveNRlUjSTqFAi0wU2MrcSvu86cloDOz2pXeq67sjfqddy1JS3OnxnOmgQ9u/0QDs1
	 7ZYIhgrSH7HEjagNQaqSsjXoMx4wwL8c2DQ6CchNwM4cPa4TiClARXR4RaewXLm/CXyLg
	 GoYa8yCWldLxTJSTlasWgRcelllHTlFDnYvBspqtk2CuHoLzncsZukBqxMiv9bZzfqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794897119;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=2gJeu9lz3FypG3Skb0xDHUuQAQkZLfZt0HTmDptUfys=;
	b=U3/8dmdlOsPqOmH5ebK8XL+CnZlJLM4DRJp3d3swb0h0LOpB3pAfr2qmJVQ8onHoS1rY
	 1nbYTj1EMRQFETBgmNPEqNFEmxX5+7gyQ8qs7qirymZ1+de7DCShwv/9R55K8o+SHvmHh
	 J8qNQMRNjvhDewP50cCAIJVfP5FMeE/ngpUnPUqjhuL3w9EagDhZjnqAWkZKU8PINekZV
	 44RlrSQQ6BpLnPCs7Yc8PdZrhoMQIIj0whOWv3h1YAsQ6iuuZ7TTAw9CHqWaf/6Hf7ayD
	 /fWCKJ32pTIGIQAcRSE95bGJ9GFEJVt9lCjFZ/eA8P/MoMTRFXeU9kzn0tBUGPHqvxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lJRvLjGO;
	arc=none smtp.remote-ip=74.125.227.134
Received: from mail-pj2-f6.google.com (mail-pj2-f6.google.com [74.125.227.134])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ADAE606A31C
	for <damon@lists.linux.dev>; Tue, 17 Nov 2026 06:31:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2ADAE606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lJRvLjGO
Received: by mail-pj2-f6.google.com with SMTP id d9443c01a7336-2e987949882so29849715ad.0
        for <damon@lists.linux.dev>; Mon, 16 Nov 2026 22:31:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794897117; x=1795501917; darn=lists.linux.dev;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=2gJeu9lz3FypG3Skb0xDHUuQAQkZLfZt0HTmDptUfys=;
        b=lJRvLjGOdHfOct4L+rNgquSngkB+j638odvuWMclC+h5Tz1r/G40YX60r9ykXxq4Bo
         KO/Ak5XfkzhahcHQzncZL9MODFFU1nCkCrftsXoCTUJmpGcr0bRCi9jrrSenxMXyb4aO
         XYMjxtclNEvWAubCmAGHRRRdnML/Aam6EQIXGEeKrmeBVdlYIUpU0eya+krWr2ZbITYb
         5EL//B9TpLFYbvngyVFg5lWCsX6gReFrHms+LmsI7wb5np4+ZtRZv3X+iRnYIp/bBFqC
         XWPFzykI3znv7wNhnv9dyrfpXqqPqWObctapo48eTN87Rt51gG7pQHm+tR3l4KR25jht
         qs9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794897117; x=1795501917;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=2gJeu9lz3FypG3Skb0xDHUuQAQkZLfZt0HTmDptUfys=;
        b=JvKbaLMVe8p6ditx/or6AtZ7DRO5Eq6iLEP1z2spZwpdxQpmbLoszfcW2RiKBkRAIH
         fHJle0laUkjxhIl7xEzwy7teKqZFcGWauARtaBJHECdol4Fv9TYdiHZN2euyBZzSgcQv
         Q+Ntu709cr7ruxAn7FdmgjRJW0wDDd0a9U+Og1BRuRsDR+XZUJVUxetWA4m2UECGMozJ
         O1KzI8OSIc/96cxTiRaPLHsh0/duR26gS0UWLMYX6tre+SO/DiZI2iM05BE7yfL8AdQo
         SPDibBdu8tJkhvr8GzSE2fpZfVuk3pfEwIB8+LbEFTxYwT0nMJdHm4pqwXHae6m4Hn7B
         z17w==
X-Forwarded-Encrypted: i=1; AL+hErEogJD8gbd+K3UoHUAVhlDSU/etVAR4O8R+PKEr6wMqy3yygEGCJ45qH+7t75541/WjeIQz2Q==@lists.linux.dev
X-Gm-Message-State: APuU4Z+QqZ95GX5DY3IwUl6Pvxj3cFUh1kD/sWnRFCN4/3mBq8h0nz8H
	CIT67d491oFae1mLYWKM/8B8MmohhWFxWQKl6tAw/gXPDUAxzBL+HZCc
X-Gm-Gg: AYBFou0QOYnXhDvPdPg69qnjAypGLQ/DeH5cKfHe5eO8JWMX7Nm7EdMIYReC13HLksu
	vDqiBz+YQXnbzqoXxIsBWTEChJ+TYDwo0/1Ptm0ywEHlbMlqxYgdTN4bKHHinuESJ8E2foNzjhv
	Io9UlETEgLIhM0Pe9z9PPX7W0yHKBgM/HoXfN30MdKQnXIBYS/Mgv3lioov1LDOUR6cs1T3RpG9
	JASc/4I6p1dCLRlxpM7z5F+nzHTcpnBDCUgjsSHKFLy033dB1fFd2FVMXHrYptBrIUPxMz2CVIR
	SS17yFUXrmlyG1OLNU46FeqO9/wDrmXfl4KZBVeJm38qZFCvufJb+SCC8IJ1mjO8Rr4twMWHFPt
	mhCZjKyDZfS3xXKuqCVqw+SVHSwHxzXwrXm1dBs/dbZqPP+I54XoJAtyycMmNjp0YjK3R+e2IEY
	7dd6TQtMQtnfJi3UTuYdrL+wmaOAWPPaQ237sxNQkTut0fls74M5CW8c2GPWHIt0hN0KOk+mavC
	RQ+Vym3yJ7tctV11+Un2GfHqIFlcWOzbpumWomk2unh78A5izGdyWymG7fsRMNiU1xpAc/DgdfE
	BMvlxPfo7XSZgQt2f6HooFIuYyrmS4YPupAPB1ZtPStm7T7p/QP0xG2nBMqyeER3ERFXoHRw+5L
	FTOuEtSkdX+lq9IXkHv78Qs3G57wHNAkkWWRuIZ5ocD/r1NV2Sdva1GwB7Y2U4yw=
X-Received: by 2002:a17:903:988:b0:2ed:3e3d:f0ea with SMTP id d9443c01a7336-2ee0dd2bb4emr122131505ad.20.1794897117285;
        Mon, 16 Nov 2026 22:31:57 -0800 (PST)
Received: from localhost (n106-71-19-159.sun21.vic.optusnet.com.au. [106.71.19.159])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2efd7a364f6sm8477105ad.27.2026.11.16.22.31.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 22:31:56 -0800 (PST)
From: Aveline Noir <jm5905938@gmail.com>
Date: Tue, 17 Nov 2026 17:25:36 +1100
Subject: [PATCH] selftests/damon/damos_quota: skip the last sample when
 counting exceeds
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
Message-Id: <20261117-fix-damon-quota-selftest-20261117-v1-1-c65d687d3def@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/z2NwQ7CIBBEf6XZsxsLMSX6K8YD0MViLChLrUnTf
 xds0uObzLxZgCl5Yrg0CyT6ePYxFBCHBuygw53Q94VBtrITQih0/ou9HmPA9xSzRqany8QZ94a
 ynVCmPTl7llA8r0Rl9P+43jbmyTzI5iquDaOZ0CQd7FCjTZ/nuDuP44iBZljXH36dM/OxAAAA
X-Change-ID: 20261117-fix-damon-quota-selftest-20261117-7c617b04fc92
To: SJ Park <sj@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, 
 damon@lists.linux.dev, linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.16.0

damos_quota.py expects qt_exceeds to be increased for every sample whose
tried_bytes equals the quota.  The kernel increases it only when the next
quota window starts, so the last full window may still be pending when
the workload exits.  The test then fails with an expected count one
higher than the actual one, e.g., 15 < 16.

Do not count the last sample.  Also drop the sorting of the samples, so
that the last one is the latest.

Signed-off-by: Aveline Noir <jm5905938@gmail.com>
---
Tested in x86-64 KVM guests.  damos_quota.py failed in every run before
this patch and passed in every run after it.
---
 tools/testing/selftests/damon/damos_quota.py | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/damon/damos_quota.py b/tools/testing/selftests/damon/damos_quota.py
index 879115a499bf..bdfd22f00079 100755
--- a/tools/testing/selftests/damon/damos_quota.py
+++ b/tools/testing/selftests/damon/damos_quota.py
@@ -53,15 +53,16 @@ def main():
         wss_collected.append(scheme.tried_bytes)
         nr_quota_exceeds = scheme.stats.qt_exceeds
 
-    wss_collected.sort()
     nr_expected_quota_exceeds = 0
-    for wss in wss_collected:
+    for idx, wss in enumerate(wss_collected):
         if wss > sz_quota:
             print('quota is not kept: %s > %s' % (wss, sz_quota))
             print('collected samples are as below')
             print('\n'.join(['%d' % wss for wss in wss_collected]))
             exit(1)
-        if wss == sz_quota:
+        # qt_exceeds is updated when the next quota window starts, so skip
+        # the last sample, whose window may still be pending.
+        if wss == sz_quota and idx < len(wss_collected) - 1:
             nr_expected_quota_exceeds += 1
 
     if nr_quota_exceeds < nr_expected_quota_exceeds:

---
base-commit: 67f3b04b277373438f17300e056306adbd9edf7b
change-id: 20261117-fix-damon-quota-selftest-20261117-7c617b04fc92

Best regards,
--  
Aveline Noir <jm5905938@gmail.com>

