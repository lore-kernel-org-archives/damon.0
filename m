Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794585556;
	b=szkO96EpByOzP1GOTFLpyoVtV0foCTEbqcTFIKzOVyTrCg4Jb/eBR7N6p0d1yeQXQMQz
	 EU4V5mQBX9RJNKx+E3/dW7u8yeZkvFY36FDhz9xJLLflqtLe7M9TO/q9snuDBeQHUza6B
	 OgDAKUZnLxKt1dkSKHjwIn2Wl+pldEDLoiucOT6l8ukm3CahHPfD+6+KhGdv7mge8lJGk
	 wZV9fX9mJEPxOS+wcex8eIkUwObiWeZwHK/8JdidZbmjAl4JUz6tShzSLZ7smEUdyvDnH
	 dFxUAx9YFjRK1Ed/mB31q2L7hRiAtrbqiSh9RmG015bXb/GfB5u3R7hj1C09v4wKeAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794585556;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Subject:Date:
	 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=aIRQL3xPbHGiEB8Nq3QfhoUZhbnBVyn8ckiUXc1wE3o=;
	b=BIoyv4MKR+vj+gczdZEkfcRqHodMOUcLJ1C3o8mKQqG6J1Ug8mYXbMXX19ZEw6HWVnjo
	 lawp2Le73M67oj8SLDlhwSdVFtjYx4OluR8dm0TcYu2ctnhKesCHPAYCNqkLHa8Ahvj90
	 wkGE0Rx+9R9OcHzYBA6ns9woeQw4DIZ9yNEyn0fhHS3jK946n6ewqUrcW6FPZ7LePlENR
	 7FnXgNBP4uKum4kT3YjAiwVBAkptnZPum/a+IoeV0gJjg/4+nY3DApW90372f9XohRcTV
	 ry/agBu+4sfJH5DZmrHCXB6vPT+7QfJMc67Uk7XV8I9jMeIHp0rO73yywmLy7RddoDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ucla.edu;
	spf=pass smtp.mailfrom=g.ucla.edu;
	dkim=pass header.d=g-ucla-edu.20260707.gappssmtp.com header.i=@g-ucla-edu.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=rM3VDDcI;
	arc=none smtp.remote-ip=74.125.82.49
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D203560A6F7F
	for <damon@lists.linux.dev>; Fri, 13 Nov 2026 15:59:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D203560A6F7F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucla.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=g.ucla.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=g-ucla-edu.20260707.gappssmtp.com header.i=@g-ucla-edu.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=rM3VDDcI
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-15ea896ddc8so1470570c88.0
        for <damon@lists.linux.dev>; Fri, 13 Nov 2026 07:59:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=g-ucla-edu.20260707.gappssmtp.com; s=20260707; t=1794585555; x=1795190355; darn=lists.linux.dev;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=aIRQL3xPbHGiEB8Nq3QfhoUZhbnBVyn8ckiUXc1wE3o=;
        b=rM3VDDcIxH8Z8s8RsJNiWBJRxJfmg8z1cHQeW9+g74N8gGiJKPY1frUVluL7v5cEkc
         uhS8jlvGqj+rjQRK8zYECyQyDYZM94bl8C87EdcxgOSDhyAhG36EDmSbwrf3xjweRVKZ
         u6hqjV8SvqFA4aSKVVE0FScY3BrcaqJrCOj8XZQbs6Y13ftNaBezpkCn9mg8nclAVFwq
         XrNEVTHBfupVe8BBEjaIxVg5GTXcacArGbAull9lsYit6RcKE7sGUc4bS4OsbZYFNwPb
         ErDefM2CttzsNb6f9T6H5pOgdzG6EdHlrAxVL6ZQLUodJWo1giageq87NjWWmTYb34ek
         924g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794585555; x=1795190355;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=aIRQL3xPbHGiEB8Nq3QfhoUZhbnBVyn8ckiUXc1wE3o=;
        b=DEOCpC5HpmduNpBZBpm2HJMr2Cqx8r/L5wSLNtSZyUvh3ric25VuIplMpIgYZUbAVN
         zOFpuWFbDXpRvIZvfYMOeh+jsT94yOuUnUFM4WMWNkfmd/0x0COQgpnAqss2enKff3k8
         A6RC3cnmii4w+OQRWNtqOEpcPgQR94o0pLwJba3aC5vPwhAUZo75CVOs84j39X3s7JXe
         V9Fitp7IP6b1iMscCQVPG/BVxxzKoT+V0EOgxcnFgwdZYJasaloNleyLCoNNnJzYbsPe
         cEjPxbC1hg+2uBeERdpjIiqq64n3QrhsMjeKNGvzMI+si/FNS5XK8ljR1Sk7gyxkXCy4
         3cVg==
X-Gm-Message-State: APuU4Z92bs7a4w1v6yt6Izs39EapBVlv+vgiM2nkwTdnLf8A8Fah1EAr
	ZGuqHfR1XPDxRoK51Xs58MutnpBa1QjOnxyfX4dTn+jr6BICO3yeOlbPhkEkm+ecxt8=
X-Gm-Gg: AYBFou2QsDtg/C1NuhfapSwjp562eB4ZAKOYT9WRAFVgfDXYAEwe68LMksBRcqXLwND
	wnX5JZXox7bZo10lHPRFt2WlqLP+QwL0EgRGr1B+rBPYgPftElI1+VJ3Hz6FTCBpAHGpdfKoEhd
	PF5yMpTTZv5EgKNXOjoc9aRkJPpG9Z/BTC8uNZ0VTRO22KKOb/Xa3L2QzLJNNRyKpAlxfqx9tp5
	buG98O54eYv/xnEUNrDJRcmJLl+6Ve8kMap89L06Ht9J1nCxeAOyA06Oi/Ci/OMyG8iAZYTV/a7
	F/yKCH/7HdBoitT97y/ctTzyHU+X1sZJSk2ONcw6gEC2gpYv+Q4I1vTuUiFt87TEOlnhOySg7MZ
	RvLH7q3SVUrAqLX1ukW69JSqr4YY/VDYO97nZLMYTk751FB1lin48TwON5q0A5ObKNxKhuYa4Nl
	2Krhr2UeCF0RMPlg8F+7BJxcsF/TEK+hEJZfZZsAG/tjUjxgVa6TPpYzUl7IdzC5Eztru2pEfLY
	0obe5hYxREj3MDWLFVShMxeUBDC2mDnjE0VUSAWobWdQWwIESOkd0GUC0cpCFuxF17QEFBQyQBs
	JBE/8om5sHn9HbFOHtU7uZQMlrKK0Q==
X-Received: by 2002:a05:7022:3c03:b0:1b2:42db:8a1d with SMTP id a92af1059eb24-1b5030cd460mr2271552c88.29.1794585554755;
        Fri, 13 Nov 2026 07:59:14 -0800 (PST)
Received: from [127.0.1.1] ([131.179.95.34])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5031bc518sm7868383c88.15.2026.11.13.07.59.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 07:59:14 -0800 (PST)
From: Jason Angelov <jasonangelov@ucla.edu>
Subject: [PATCH 0/3] mm/damon/tests: add KUnit coverage for age_ms filters
Date: Fri, 13 Nov 2026 07:58:54 -0800
Message-Id: <20261113-test-age-ms-filter-v1-0-b99eab2f71bb@ucla.edu>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2MSQqAMAwAvyI5G2jrWr8iHkSjBrRKU0SQ/t3ic
 QZmXhDyTAJd9oKnm4VPl0DnGUzb6FZCnhODUabWWhsMJAHH5A/BhfdAHq2tirYsqDGqhBRenhZ
 +/mk/xPgBjyfsPGQAAAA=
X-Change-ID: 20261112-test-age-ms-filter-9953843e7204
To: SJ Park <sj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: damon@lists.linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 Jason Angelov <jasonangelov@ucla.edu>
X-Mailer: b4 0.14.3

The DAMON core tests do not cover DAMOS_FILTER_TYPE_AGE_MS. Add tests for
committing valid and invalid age ranges, identifying the filter as
core-handled, and matching ages at and outside the range boundaries.

Region age is counted in aggregation intervals, but age_ms filter bounds
are in milliseconds. The interval-change test checks age rescaling and
filter matching after both increasing and decreasing the aggregation
interval.

Signed-off-by: Jason Angelov <jasonangelov@ucla.edu>
---
Jason Angelov (3):
      mm/damon/tests/core-kunit: test DAMOS_FILTER_TYPE_AGE_MS in damos_test_commit_filter()
      mm/damon/tests/core-kunit: test DAMOS_FILTER_TYPE_AGE_MS in damos_filter_for_ops()
      mm/damon/tests/core-kunit: test DAMOS_FILTER_TYPE_AGE_MS interval changes

 mm/damon/tests/core-kunit.h | 107 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 107 insertions(+)
---
base-commit: daed51c9105158768a3949395135aa6e0a04bb7e
change-id: 20261112-test-age-ms-filter-9953843e7204

Best regards,
-- 
Jason Angelov <jasonangelov@ucla.edu>

