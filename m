Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794462404;
	b=ZUUWov4kfUKOLD4Sg1yuUN1uINydLSByJBqnh2wn3HrAbEnJ9RJY5qpnCd1lZOWk3wdW
	 hNvK89iSyi4rQ+qzJUNTDbwmN9Nsx9PtYIY3SanVSd0wuWEjzZdYPlcaKDEzMdODSR/is
	 b2le7JUEinXc2Thiw5xOVLvUKkRoGpesruovGqtyRzrWAbVPMq2dqD+f2g2+loCac9ZRS
	 BPzMH/wdwL09qbMD7GmSUyyt/1hTF1OGcsfCwIzDcBKFNMF6dImi4H/FV6pdc9qKZHZLP
	 Vg1Pc5AnNLaJ/0mZDTCGPqOLP/Jzas8+3pf0zHNjp5vm2eZ64hZ1VKv+64imMUw9LBw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794462404;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:Date:
	 Message-Id:To:Cc:In-Reply-To:References:X-Mailer;
	bh=+13rBtkeR+s+DndYboZRmZoW8VMp8Nay7Rh+6kbD7E4=;
	b=yN+XnMQl9GXiB9zevnW7LeVyYTx/euE8/4RxAPWEoUFqTCnXAQxJoDwPx/nm89MLa1bE
	 B8xSZRrk+G9jztDw0xAzZYn2Wt2lUS1AG6/RVQQr/y1y6X+WOlHpGmUr8edQFIlzqrTyZ
	 Pv3l0rzZXnCvfhMw1Ws7u1XzzIl2YC8moAKAmPOKAgVBQ5jPaGb42fHmomCDBQfz0DoPK
	 K3I3kAe8p5csi1pHfu1vrmHxiJzd00ldPoTMKK3Y1u0gpPAuo5YX0C9cAuY7FpfW/9GlK
	 3E9rBSC2o4Angc1/QSYKGipAJaw5exzwHT7qzqxGWFNMS0a6dgJv0yuHQx2OvulbvNQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iDANefkk;
	arc=none smtp.remote-ip=74.125.227.200
Received: from mail-pi2-f8.google.com (mail-pi2-f8.google.com [74.125.227.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 729F4606A324
	for <damon@lists.linux.dev>; Thu, 12 Nov 2026 05:46:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 729F4606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iDANefkk
Received: by mail-pi2-f8.google.com with SMTP id 41be03b00d2f7-cddb56fa486so82008a12.1
        for <damon@lists.linux.dev>; Wed, 11 Nov 2026 21:46:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794462404; x=1795067204; darn=lists.linux.dev;
        h=references:in-reply-to:cc:to:message-id:date:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=+13rBtkeR+s+DndYboZRmZoW8VMp8Nay7Rh+6kbD7E4=;
        b=iDANefkkj7g6v7UQ6DwBJgEjUIIcP01zfkZltFf9nEiAYnzd+ExzG8ekg96UGd7A1+
         yPkj2y0Q3ZLcF1YU9l8W9S34AiXGDqmnJfActo6U19Cz1lG/lKJc+/YJwd/ffE3ULTW4
         NHQ3PoW0NbleFtjrNp7RPfa6WCiObeTvqIjLE0bbB2UQ4BjqDrNaEGEG3yrXQEgcBh99
         NkHifcATeze0v+W1X96A43ev0uayGduF6oQ060G93CDmUYg3O4omfACCl3Y5Cd7sxK7M
         Vl1VjJSELOxmSsWoJlDF56Eb+peHuhYFMCxH9MOa8ugT/18XclYEprhKLpOmlaFu16yX
         gYzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794462404; x=1795067204;
        h=references:in-reply-to:cc:to:message-id:date:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+13rBtkeR+s+DndYboZRmZoW8VMp8Nay7Rh+6kbD7E4=;
        b=AUF6TEp/9b06koX3qG8gYqkZq/UH2Uh4G+Y9/LqvjkJCYxbtJT7gJq79QWLxx9onW3
         u2Hk6UjduU6BYk1OYSe0Q2vr1Q2h64SW0WhmB+DVId3pmD0tHKg07lgbjhoJhND7fstq
         BzjxrVV5Uz7NsX3lvwVgCeegYkevHHG+xc+m4dwSR2vV1PzHBiYlEPdRilwu6y+h74bz
         gjQ05VzbAFI4hEoEtqG9IScyzqdNB3Z1CNjMslGYft9kT/VQ3auTMLiiso4Jahbyy9Uo
         aRWw9Zz1YIW9QgZSS3lmK0uNl3kgd7Aed5G7mf+a9y/F8UIiuoBpypivucYwufZgdGTp
         fCIA==
X-Forwarded-Encrypted: i=1; AL+hErECUJeHjz+eIHWnPMqZDLekYpqnQcPRgvGiIjDutt3zubHiRpftSXH8c+WL6CRZaDP4SfIFmw==@lists.linux.dev
X-Gm-Message-State: APuU4Z8IT+pttjHq8rRgoFKVHuX8QAHLRWAowciDrnD6ToD0ZvRlW/kb
	COWqwLQ1Z1nDx9Fy06Pw2uO46tD9oi30sQflIyGE07y/K6mPWrJsGgvK
X-Gm-Gg: AYBFou2tCg7L1U3TyWy2/KDRl7s5RVLspoxh5J5pW3xldOfEESoFvajIphxjCLIFzho
	EKNtR3GDjKp0n4SX775OeyojOrhElbqv6cSC1Ae6aaX1qZBTGPCWwIevrZXhT7QkbZtLBMZQ74x
	0jnNHstPl2AersyJwe1czS3EM4bw437vjEMf+rDZck1NB7vCDQg3FAegrh6eQ0lHfb7L2hQOpbs
	7ZwP4cWCpJOA5UfdNYizkQOjLWD+5vHhD6XImh3wxSzrS/dM1NYlSrzHwhNZmFgohlpAiwTcS6p
	44q4jU1ehC0mndzOKQyPdA7fnVSHsWmyZuQ8rCtGr5fGAGzK9l28etQg4MRWGZmIeH2wjwNVKEx
	pV46QKyxFwtzja+ErQz3GWPPbGKHep4SCoIZnuP8LNcq58+vTAhsKEWiGhoXwgiRmBjBhESZ3Hs
	WZlAllGsmjQJfJpRKEj8l7qFGl4C03e5zhfYw6Yujm0HqUboxyX0X/5YJD/8bK4UW6LSvtoyHQ7
	8F/Sn9o2p01Hy9dBLzed0w7prmQg1n6tg6tqUNKC6HvA9anlOsOhgtoTGMRyo8iISRG3OfEIaut
	dWULQnBA4PlPwrEeb18PSur1iv8mntNnLHHvFEiz4djMNMX8fmt1YSN3XyrRfTLkIplXPUhrewb
	1SdQOc7kRYisRK6ApIplFHbE4Xg==
X-Received: by 2002:aa7:9a86:0:b0:8a0:4032:af85 with SMTP id d2e1a72fcca58-8bc16651ea2mr4128251b3a.0.1794462403606;
        Wed, 11 Nov 2026 21:46:43 -0800 (PST)
Received: from localhost (n106-71-19-159.sun21.vic.optusnet.com.au. [106.71.19.159])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8baab8dccc7sm2776591b3a.52.2026.11.11.21.46.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 21:46:43 -0800 (PST)
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
Subject: Re: [RFC PATCH v0] Docs/mm/damon/design: document data attributes
 report infra design (beyond page table accessed-bit milestone 2)
From: Aveline Noir <jm5905938@gmail.com>
Date: Thu, 12 Nov 2026 16:45:39 +1100
Message-Id: <179446233975.762943.16115029371266375222.b4-reply@b4>
To: SJ Park <sj@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, damon@lists.linux.dev, 
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
 Ravi Jonnalagadda <ravis.opensrc@gmail.com>, 
 Randy Dunlap <rdunlap@infradead.org>, 
 Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20261111185412.145514-1-sj@kernel.org>
References: <179438255225.3134195.10613668244848761847.b4-reply@b4>
 <20261111185412.145514-1-sj@kernel.org>
X-Mailer: b4 0.16.0

Hi SJ,

On Wed, 11 Nov 2026 10:54:11 -0800 SJ Park wrote:

> In a real implementation that is aligned with the design,
> the probe will hit if a report associated with the sampling byte exists.

Ah, I missed that.  Thanks for clarifying.

Thanks,
Aveline Noir
