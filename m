Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795746602;
	b=Im8JO3us2ZwTVtm1OSCScvBbpfD2aS/4rAmVHiioCJtMz8emgMdpDwywqMONARBpio9y
	 4tH7ppyIALQPTuQQMUcOrDpwLsJUwOPocJrFHOwtX6K/a/PNFqeXWWMLqz5jZN8s3jmwL
	 Dmp2y+8UlFCNemx+HFPkLOq35zXqefD40zfo6d+EtVjMSx/BMydt2TUkqPU70bovJFGZo
	 8fWO1rRkR1G7Kans0uPkkARrBjR1Kah66/+qrSQWyu1E2HsWIow9dpVl2PotyZjIPOAks
	 xVfLyoBU3nbk9XR+y8X4VEM0wBHyPblrVv2kxJfqzop6NBXPQe5LhYhw8Z4gRtsn+bQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795746602;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 Content-Type:MIME-Version:Content-Transfer-Encoding;
	bh=YJr25Vhq4P76gjl7pK0JdCfn3jlkiPef7UPUuvz/uYI=;
	b=bfcvf5AGK0uWO8thJss/oJAHkE2WIYZfcqbad9001GC+bm7V0TATwAefG5K+uaQqwrtC
	 Vv0XMNqubM7TF4hFUhGz5rzMl4DOWT45pBhgCT8gw9rMJlDqKoaIXn3gz239RR71iPlQJ
	 2/GOgKVHr1114AQpAsCOWUSx3tJISw/u5gy6HdCitwV4fB3E9aBdNtV4NzRzC06H+iP+H
	 zYMTR/uVjC99UrfDABHVFIsgytXaynrd3MoWkw47ovWeKio7U+8cOQCB7BflTi/ycvB9l
	 b8KpxHKdvWJEDhUq5AeiGcSd2ybVvCnt0TZ49Ng7oPJofrpwwjGK4AU0kzbzEYtNRLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UEUQm1Yo;
	arc=none smtp.remote-ip=74.125.82.49
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D85606A326
	for <damon@lists.linux.dev>; Fri, 27 Nov 2026 02:30:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E3D85606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UEUQm1Yo
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-15dd124bbe7so11067554c88.1
        for <damon@lists.linux.dev>; Thu, 26 Nov 2026 18:30:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795746601; x=1796351401; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YJr25Vhq4P76gjl7pK0JdCfn3jlkiPef7UPUuvz/uYI=;
        b=UEUQm1YoBKEnS1B5zIHe+9VozPoK+xOVTefubGLC02zVQSuoGBM0Vl4ng0wymNHD09
         NK5QplyZ+4shlGo3SALMRWf2EsZiza5k1vp4WHQ7BldHfGxKJbCJiCU4aJsgNoRKBzwY
         /6TlI9cSlp/ZI+lOCCsovLiRV43gZkcsHxXvLjwaYdzi0+aZ2I9/pQnFS9XZkq0/CBG6
         j0jsCfCL6tiIKAscmJyz4C38T/9rXh9kge1WoZljQ+wwh8AEe5ei5WIj3AKosk8DgQTh
         y1z/XYa2NLhj7Pdce/vnSx3VNoOclGDouC+XLmpv3WN8+hnHsTwywTe7eGgK4OYnc+R/
         YLeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795746601; x=1796351401;
        h=content-transfer-encoding:mime-version:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YJr25Vhq4P76gjl7pK0JdCfn3jlkiPef7UPUuvz/uYI=;
        b=CVtATgkRLwohxn4uQUsB7t2NvmsfrsSZ02bdDMESM5fa7NzFBt0k3AOh4GgANvJXVF
         VCbodzh5+UGIhyA7OG6MFd1J0zqBGUc01cyG7PTvfIO0+OSPtb0u7/vjW/6RjAkO1RUf
         EYR0T3U0ZopD1Kpzs9Pqu01SwJFbhOcmnCFW9oo0y1wTtTaLDgdBry5DpU7YxbA/1ZaN
         s6FzNgQszUuz7Vt7P50eFH5LeXfT5/HnXInlmizGSi74SSf36V0O5xlQGr455QDXpbSh
         6InK7sUcG0dm7SJJZq0vCEChAe26qAU1dtTZ3GINsHYrrdmv4KeoJL/msZ4yhVX+Eam1
         LK2w==
X-Forwarded-Encrypted: i=1; AL+hErF0eNrxqBvvjBm/SbXglekf2d3++xqex32+mstx1jd0mf4kciH+JVOw/8kpCloIBcNr+qmYJg==@lists.linux.dev
X-Gm-Message-State: APuU4Z9SLr1fSLLhupjm9Y3kdxgZBZu57YWvTWTcuRfD07aI8JW+GZ1M
	DdmLm95EtauL9j0eaJ8fPmbSLx/gd6WTePx23abyd5qhS9m7EI4eHY1l
X-Gm-Gg: AZFdTZd+RnUPZH6TjKKTfS8pHLiAgFfggH+rHF/558mBbgn2QL5J4nHpPqcLxkp4EdM
	Umcc/mm0+lH/NdAFSAzdhJJ14uAOXqfDPdS08kdsPv7I/EprWnogGpWJ4duM9jwJxOIGoXkwCS6
	LcNdwl2gOFj3/Rt3iq2oVN9eXhyM4i5VIAvU1Wzwow0+9mYk+r3v668GwFW3mnoE3AEfwedFxp1
	3OMe0dAYhgDhrBAA2VQAn1W7vFQO8A42bxiLHAjqCgkFJRWwjfJo2GyLKfuAaHFnso0vvLZpmCv
	fJQtpMguwIHZgDUMtBTa4P2po91WLPQVP1hKgW2I1NMXcYS2lZ9VGlWi3pvrzElh7N/nc3HqWlv
	aqE8C21h/rKUPgAtpm54Dz4GKxiOJyLGX22jq07pcImuSl8SvK5JVliAC4dCFsgJXCvWWvuomuh
	ez7xcyUZOB9NKuYxV4ZWh0Ia+ugqqqbIAgWXyUt1qauDzqTk82/LzMLitpSV9QuIfzQpzz+xFyY
	N5gJZxxQ5QAExpZVbs8/2Cr6K3pen5o/TpQOJeR2UNRvAXTpvNtN3qAYuxCP0zf/PTRvmb8DnPB
	IRxo+YA2i8J8c7gRyEzi1Bb9Q8Bks1NBF0vk/H6xNRHKPOW4jiEZnwtn80zqgUV1TSy7MJTyi8I
	WXsGjLA==
X-Received: by 2002:a05:701b:2087:20b0:1b4:fa58:9d8 with SMTP id a92af1059eb24-1b5568e76a5mr22857082c88.20.1795746600887;
        Thu, 26 Nov 2026 18:30:00 -0800 (PST)
Received: from HFGF46V04Q.bytedance.net ([203.208.189.7])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b556829d31sm86938260c88.9.2026.11.26.18.29.58
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 26 Nov 2026 18:30:00 -0800 (PST)
From: Lian Wang <lianux.mm@gmail.com>
To: SJ Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [RFC PATCH 0/4] mm/damon/sysfs: refactor state input matching
Date: Fri, 27 Nov 2026 10:29:21 +0800
Message-ID: <20261127022945.8243-1-lianux.mm@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261126210619.97634-1-sj@kernel.org>
References: <20261126210619.97634-1-sj@kernel.org>
Content-Type: text/plain; charset="us-ascii"
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

Hi SJ,

> It is easy to mistakenly make the order broken.

This makes sense. The explicit command/name mappings preserve the existing
commands and state read/write behavior while removing the ordering
dependency. LGTM.

For the series:
Reviewed-by: Lian Wang <lianux.mm@gmail.com>

Thanks,
Lian
