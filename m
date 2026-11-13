Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794585560;
	b=T+jKhZHB7BvRT5NCrTTRMRhHEzEO3aIdoBhgD7sLrpqQOTSgEaZB1RcL+CUeJyB0Dep/
	 9/R9coXbu7Hlx44/djv2f2EGjb9fiWTk8Ph3+9PtZbDacKlClTwZ51Iu02o8Wb9Dgogby
	 FjIjPMdRGcxoscLLJyh/UClZh0GXFB2XUfYTSpvIXp6QiuYxzWH+oFdd/WwT1nkznp+6e
	 n4ujvKA6AxPg5TRoFDDI1mYTS+IXQVFoseNlGoQ4Tc5ZHEXcMQ0T42OXWFTkAz4MmITnz
	 a2PnExqP1wP7SHl19piuZgGW9xUcC523Pxjk7xmOvbMVW62ofRfix6gFWIuhcEPqa2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794585560;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=CQfzRALCDpL4DLVl9bz2Iqb7R2/WHPaCJ3qKGqNNiOc=;
	b=w8hwly/+2hcQ9je6iFLUSPy1Ug4iWbXPmDt0SWwh3aFydp5uKQSs0LFwPEOmShpkkug/
	 Hpz9W8xZvtr+zrpZPfLZPfQAdguBgryMfFLmfr8Jo7qUP/b95CJ4ZRr6lS3BuergopHB+
	 DTUixUTa9yqmeep/NwBl1W6BFKOnvFEu5q5CFdkaO1t+vnJFmZKZ/iEXV4BQMa1VSnNJr
	 H06DIYuDv0CUkz3/zQBx27gv55zywWXE+3WKosm2baFXdNH2yndX2VUuWgGIioNgmeLna
	 yx9yTTwL7MoUv22OO6H4F3/cEVxkEIAVzPW1j+3faRJPG03EC7zrX7gdXrRGGNw/Pjw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ucla.edu;
	spf=pass smtp.mailfrom=g.ucla.edu;
	dkim=pass header.d=g-ucla-edu.20260707.gappssmtp.com header.i=@g-ucla-edu.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=Unnb+rxZ;
	arc=none smtp.remote-ip=74.125.82.47
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34DB606C573
	for <damon@lists.linux.dev>; Fri, 13 Nov 2026 15:59:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C34DB606C573
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucla.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=g.ucla.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=g-ucla-edu.20260707.gappssmtp.com header.i=@g-ucla-edu.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=Unnb+rxZ
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-14394530ec6so1366810c88.1
        for <damon@lists.linux.dev>; Fri, 13 Nov 2026 07:59:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=g-ucla-edu.20260707.gappssmtp.com; s=20260707; t=1794585559; x=1795190359; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CQfzRALCDpL4DLVl9bz2Iqb7R2/WHPaCJ3qKGqNNiOc=;
        b=Unnb+rxZCq3afNdQcqAgMgNhKKXWRHUI28xxu42sDMfQUgZwR2MljTXhLGBQFYoF75
         st2JWUcGuqDFmWVlO0eqpTiWTdjNlGX4V7CLelNJJtbo2tmcdtDqn63hjgz6+1xIB/ou
         LnoCfOZQncVmnI2yU1PivYWVfm4cWDBV6gsNZTixGVdfF5bAI8LVc7vA7M5hiS1qdO0h
         4JajtwkZ3jlkPKsG92gutBOjDnLp9D0TGqK5UkM81b4v39fgEPyr+D8OPROGwfnBksfp
         F12oey8VaTfUg1iv5qS+fQajosl/aeodfbzRKHpRazI5/vYf1gGGwIjfsw4D9xl6vEFk
         JwKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794585559; x=1795190359;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CQfzRALCDpL4DLVl9bz2Iqb7R2/WHPaCJ3qKGqNNiOc=;
        b=mtvSZyTdEwDyhD/5OP728RwPcHfTDlkINoGYaMKJMh291fZIGSxVetBDOZrFPQKcQy
         FLM1e4qareN3maTiW2yBH9Vg7uMfnxXl+MyidYEdcNB2tZre39mPZe1qBjc1c/lSQb8e
         2TSsk/Dj1+4n7c4nGRPzgUXZNmbuWKfL7OJR8bQdBtufV0QgbVDP+K+jTfZS3I1PUn8N
         Rc1menco7TYdq0D5KvvfF8Fvh/E8iNT+baf7AB67g0zjAXUvBXrS6PbMaFBmiGEE2S7B
         RbSjMOXihIv/TFKlVoUk/deUdPx6i5iWV/XR6axVmUWlxc4rJL97FNzSN0ygL+G+MTXv
         nNSA==
X-Gm-Message-State: APuU4Z+fTkTd5ztNU7Hui0wqtsh2nN5vJDjNZU7tbFhhcsSbk30k0fh/
	fyIgBFIYYhtyQt5TkF+GpClPNebRzvGVI15Gyv3mhRyEDRf7oqWE8nltFTJYtTRvUuPMMz3zE0C
	ZvcjNtll3Ew==
X-Gm-Gg: AYBFou3+dMZ1SyTvvL92YaMEmIDWMzkLECb19vYp412Hu8ISJ1EFuQfRNaCbM2Teci2
	xPG8jIG0xiUqPQXvUdQiWtLV2Wg3/BTkUniTkP+q7nJFuBFSqvCP6bAV1FXfhqAGIzPfPDMtL1W
	MKPiUOIUdQmtomCqA3JweuqUtDAS/JntTOSl0nrPWq0b2J5WI9Cw1FosNdVw5jTvtPq0CdflKAz
	WL4SoXSSfEOeQsGFCvr56RlykXnGUZg4F89yO0xXB0mqm5IpDkTuUMkc64yxwpOcbMoOFGLNBiz
	AotqgSe2r8PugKZsI8J+T0LO/LZwKevtCSO33blg8yK1rxmVdKBtbauCtLPmsgPpJBYFz4viN3t
	QLii7P0Eem9pHN75lUn0t5zgnRBaeBkSypvmpTCNG73dtc+IpF2Mm0GkLFyWedxetO+7tuQ6EYn
	VM2CoH7m0ItmqqmtKEbDiVVfJfRUpDdrOltJTJVG6Tph2GFDI/dQHk8e0F7aawmYCB5YIuKV+YW
	ycr1v1OL6/ofpU6QV+80XsL/QtTeiptmRALCuBh0UF/wVrFpupn4aUqaxU2Elq0QlbozrmWngxe
	4tGsjQBxBzgoBC5dFPksdFX2bE4KOQ==
X-Received: by 2002:a05:7022:f109:b0:1ad:4ef5:ffed with SMTP id a92af1059eb24-1b50313d936mr2385378c88.38.1794585558544;
        Fri, 13 Nov 2026 07:59:18 -0800 (PST)
Received: from [127.0.1.1] ([131.179.95.34])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5031bc518sm7868383c88.15.2026.11.13.07.59.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 07:59:16 -0800 (PST)
From: Jason Angelov <jasonangelov@ucla.edu>
Date: Fri, 13 Nov 2026 07:58:56 -0800
Subject: [PATCH 2/3] mm/damon/tests/core-kunit: test
 DAMOS_FILTER_TYPE_AGE_MS in damos_filter_for_ops()
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
Message-Id: <20261113-test-age-ms-filter-v1-2-b99eab2f71bb@ucla.edu>
References: <20261113-test-age-ms-filter-v1-0-b99eab2f71bb@ucla.edu>
In-Reply-To: <20261113-test-age-ms-filter-v1-0-b99eab2f71bb@ucla.edu>
To: SJ Park <sj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: damon@lists.linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 Jason Angelov <jasonangelov@ucla.edu>
X-Mailer: b4 0.14.3

DAMOS_FILTER_TYPE_AGE_MS is core filter, not ops filter.
add kunit test covering this rejection.

Signed-off-by: Jason Angelov <jasonangelov@ucla.edu>
---
 mm/damon/tests/core-kunit.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
index 0eb5dcdba0ae..fb84d30a712d 100644
--- a/mm/damon/tests/core-kunit.h
+++ b/mm/damon/tests/core-kunit.h
@@ -1832,6 +1832,11 @@ static void damon_test_valid_probe_params(struct kunit *test)
 	damon_destroy_ctx(ctx);
 }
 
+static void damos_test_age_ms_filter_is_core(struct kunit *test)
+{
+	KUNIT_EXPECT_FALSE(test, damos_filter_for_ops(DAMOS_FILTER_TYPE_AGE_MS));
+}
+
 static void damos_test_filter_out(struct kunit *test)
 {
 	struct damon_target *t;
@@ -2593,6 +2598,7 @@ static struct kunit_case damon_test_cases[] = {
 	KUNIT_CASE(damon_test_commit_ctx),
 	KUNIT_CASE(damon_test_commit_ctx_keeps_quota),
 	KUNIT_CASE(damon_test_valid_probe_params),
+	KUNIT_CASE(damos_test_age_ms_filter_is_core),
 	KUNIT_CASE(damos_test_filter_out),
 	KUNIT_CASE(damos_test_apply_scheme_filtered_sz),
 	KUNIT_CASE(damos_test_apply_scheme_filter_sz_unchanged),

-- 
2.53.0

