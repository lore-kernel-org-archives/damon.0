Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795353439;
	b=OrgUeiAdDTJ35hj2yeeTqrPoZJwWX1dLW/cP3sE+yxvrP0cKdAti060U5MCqWTniEriu
	 enXrZYl4c5K5s+fbLkUMzTOgeoAau9Np5942wz6iud2Ux1k2MMuB21C+vzywSwBB9cDZE
	 A+K9Y68W7nNpAEM3o7cWOr003DtDEg9iTl8+0bSZHzyW8/e8xxr7VOjEyCAUESxC9oiv4
	 EQWuOPbdx+oaz+W5YtKbXs8czBRzb1YUWw8JMu0KbkEZlJXUi+KlL7cVyM/ke6bHf1SZt
	 GkEiHm5vHLL236CPXoWCncOMd5p19TglwzLBY5q8rhQ5DjDxmMzeRU+epZuBXDG/HuA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795353439;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=PCrN21sAIS5vBdasJPF7/+7hDBAoVVfaCO+8Vn3uACs=;
	b=KMP53kJoSWltW2Lks2/XFNkBXAjCa5gTuQR3DpclBh6fKzhtbxDsxi8pP+ybq2neH9Ye
	 GDI3HzxqQlPu2sR/NWu0pO/jUCdqo/0QsvzeT1GfQmCWNfOcWX7bZgjNzR+q2CdUwZ0bg
	 7pwVKr+MYT58Z/AQVLhqYGZPCy2wB0E9KbbgSM08Inws0/wuMikiufqgMecnRrzlr1UkO
	 F9cc7Y0qYrzFTdhl/4aMJYuf81XAIzWCWNchic5qq908MmqfZRi5PbMX/g3hAItK50Naf
	 pUbX8dBxGwTgFbp4BLqPOC06St2dJP3MvQ+H2xnQZn/SZ0DUj5ycREzpxO950ZAJ/XQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sTonGH51;
	arc=none smtp.remote-ip=74.125.82.170
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC60F606A32A
	for <damon@lists.linux.dev>; Sun, 22 Nov 2026 13:17:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DC60F606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sTonGH51
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-38431138772so3138452eec.1
        for <damon@lists.linux.dev>; Sun, 22 Nov 2026 05:17:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795353438; x=1795958238; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PCrN21sAIS5vBdasJPF7/+7hDBAoVVfaCO+8Vn3uACs=;
        b=sTonGH51m9sJAhw1i83PyyJSdoysu/ezSCX3mX5a01CSkSoF/2stpvEA9FSYiZnmND
         IDEpLzh7xxADMPs20ccsUJIUujXvZMINjZubr+cWS8Y/3XGeAd2O8bGzu3fjmfEAHPAd
         N6zwbym9R1by4UUuZxrH+p+yXfqw/QCSxHjykbnfIkUolux7LGbBYDQVG/3eujqP+KI+
         xKU9ne2FGkAe0hHZEqGpd2nh/SMm1LIvvrrINOh/c25SMC21KxdKehpgR+G1gMU8RKdP
         uIRuCbWrck1AuLqZXrCl4piIoZcOdqekJxIN9Bnh7u8sPFYekZMFeuBQj5W3oGdCAQ5a
         Xdhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795353438; x=1795958238;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PCrN21sAIS5vBdasJPF7/+7hDBAoVVfaCO+8Vn3uACs=;
        b=CopxWiRlduHJbElPB5zb+17E+UWu4RQ/B/sWYCEz4+T8ktt4mGA62d7IIGVWikcBPc
         zHLnQAoOO1Th9RhHlXIIwZsItpXdxYo+SokiJGzNS0uVEVXOg3PVN7/e3huPFNWrMRQR
         vMSaYcbhERoHbuKpvov1+OVSl0RHhyc3O4zfUyjsaE/evRVKHntHFnt3eLSDXTR0scin
         rzybmbgEAxN85yQUL3Bs8q/U0msBdFZel01NLVhNSgNL4lOOCNNNm0gIg+ra/s6M3uO5
         DrQmw+Ihqt0gAHWQnaW8gI8UC3q/VPsdOVu3ZqcvI6KZsPL7nC8MDLyw3p7lKmg39xLa
         eHwA==
X-Forwarded-Encrypted: i=1; AL+hErHd1SIlskhADzAbNeUk/9vxb30Ok9tkCKNs3ARHtGfNxE9z2+Wf3ukjFehKPJKkNwYCaevFhg==@lists.linux.dev
X-Gm-Message-State: APuU4Z/3rJM/tK/9nJQoBp6/WhGUAZq34uXgsbzurX1ujIgr3L4OL9Gs
	KlJMDE8srBe396dBTxnpN92wGXp1wBe+8dQBAXCw0xFyi5isncwv95pN
X-Gm-Gg: AZFdTZcMqpfpx4ZZMBI/36iuQPUl+xLRbezs1CK1+d3q1FNq8269NFU+SvV3yiuAvt0
	e4edww6wcVOe36BoyiCRXSedwyB1fD0WCcaqO9TPRAhV5DH5fA5SO8YWSbgjZnuXjNVakJGjEmY
	V9VwRI3CLmQ330I2p/tv+qBYNTPNetC/vyzmh6PSGwOhbxVveQi24TvlRw95iqtSPvG4HPuyZxK
	vkOQre7PwI8adQcS+4TDoC28I6D4ZNQvP9nSfEBHOjdvUjx5QDTYS1pq3QNVYcympQjbsRsEQ7q
	e89iFTFDD7QVYqoTqoUpzzJhMYrKaxBAQ/x7tvyRPsalbRnKzav2pRYrwYEhePiHtzlRsa5vTjq
	05KTqn8NN1njIU4IDNtFZ7wMQebB7sayKWjpdfkaudzGypqE2MKKwLUI3bwZAy8JnHvonn8Upkp
	uXwFNm17cgWVWZ1PNvLWctKq9IICDn7Bme5U7htdLFrNpB2HtW/PmwMnK1sTRIKv+KquL9l1Tox
	O4DxflVHq8qBSF/a9ACoPnqen9ZTxOC6YITzHBBfBvBhxoWg5NoWq2YCbQXRwAPSTQ9XrhMnuNh
	S9NY9kUQ0hgFnL6NJijvXy9felPg3kXiMF85hxqI617IIeabimY+GWu4mAAbnNd9/xUk
X-Received: by 2002:a05:693c:414b:10b0:386:9e32:a65b with SMTP id 5a478bee46e88-3869e32aac6mr4989257eec.1.1795353437815;
        Sun, 22 Nov 2026 05:17:17 -0800 (PST)
Received: from localhost.localdomain (vmi2317719.contaboserver.net. [84.247.152.64])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38577214c2dsm25663585eec.17.2026.11.22.05.17.14
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 22 Nov 2026 05:17:17 -0800 (PST)
From: Lian Wang <lianux.mm@gmail.com>
To: SJ Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [PATCH 13/27] mm/damon/core: introduce damon_report_exist()
Date: Sun, 22 Nov 2026 21:16:23 +0800
Message-ID: <20261122131652.72647-1-lianux.mm@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261121210013.130397-14-sj@kernel.org>
References: <20261121210013.130397-1-sj@kernel.org> <20261121210013.130397-14-sj@kernel.org>
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

On Sat, 21 Nov 2026 12:59:57 -0800 SJ Park <sj@kernel.org> wrote:

> +		if (time_before(report->jiffies, jiffies_old))
> +			break;

damon_submit_report() sets the timestamp before taking queue->lock.
If A is preempted after that assignment, B can enqueue a newer report
first, then A resumes and enqueues its older report.  Both submissions
succeed, but this early break can miss B when A is expired and B still
matches the requested time, type and address range.

Could we set the timestamp after successfully acquiring queue->lock,
so that timestamp order follows enqueue order?

Thanks,
Lian
