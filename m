Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794828463;
	b=43DNQn2EiDF5rD7Bvu3RkSJ+zY68mrbsCJUcpxOu5HZLpmeV66PeqZZ5B2nWwRqYI7Su
	 cr/uB88uGviD3StUrs6p/YRGBi0O0jBwKQapBrjA/Oj2O93bB8hi8tzIUKpKB6oolofOH
	 2OKbLzYXar9rU4DB6MQ5tVA690AcpmM6yoOuyIbPCOEPQXsHsw55D/yHQEBDxYw9jL2qM
	 vADguUdUo5UosTDnoajVUc0Cpzobe3F1fMyksnadIGsNQHa553e/hElHLVS5DyZ0EPCMh
	 t61Nh/iRz9rGlhA4UUfMZjky5OCr+2BkNEit3DyTlLUIyO/o0F1W9TGTElxvPthb/nw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794828463;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:Date:
	 Message-Id:To:Cc:In-Reply-To:References:X-Mailer;
	bh=5BStpc8jowDmC9B6cxbOb1co1bGTg3WHKFG1Ve9+btE=;
	b=Ut+tz1oEc8QoX+JVdwKJHg97k97XwQD0R5KH5guartHAkp4HOLPZvr2rn+EGqE/qAB5y
	 zFuBueG+AfXrChvZJzJ0qkamieRJ85/o/2yui5oijbjlDfJXy89HM+ks6SMojnnN8MWbn
	 q4oN1zQz7y0FmkvFFN3KdQ9BMvFTZaBnSZVfSwctMCQyPZdeBrFOkh9xXlqjbJM5PSYhm
	 K58CDabuO9oZhbndOsCLtK6my4imI6AesrIuO9gUWAluyl6IKEqLpABPS4UUYTarEXRBy
	 2tE0NVt24HCDTqYGqumV1/Clj2IOYHVz8NIdu8t2DEE+dYIrdk3ALeL7wRsDlDXz0Ng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wlLDTAZ6;
	arc=none smtp.remote-ip=74.125.227.131
Received: from mail-pj2-f3.google.com (mail-pj2-f3.google.com [74.125.227.131])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B21606B19E
	for <damon@lists.linux.dev>; Mon, 16 Nov 2026 11:27:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 33B21606B19E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wlLDTAZ6
Received: by mail-pj2-f3.google.com with SMTP id 98e67ed59e1d1-3adc0ac3566so730103a91.1
        for <damon@lists.linux.dev>; Mon, 16 Nov 2026 03:27:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794828462; x=1795433262; darn=lists.linux.dev;
        h=references:in-reply-to:cc:to:message-id:date:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=5BStpc8jowDmC9B6cxbOb1co1bGTg3WHKFG1Ve9+btE=;
        b=wlLDTAZ6dVo/IfiZperTVHwywTLaSXK9o+NPphf560iieFxXLei+3pP6TcW0WCqa5b
         +kUciIH+0r0ZVmjwymviWYJp54Bv3jRRW2uQWRxtbAkaTMD7DfFVa5b1GkDkznJ+TODY
         s45DkjyseCNvk0Q00YfFUkxsYejlEnlweYuLZPUy3fxxLI16zQvdvzoa7aGCY6e9fLzQ
         bsmhdmCqy8/MwX0yIQbleKWmeB4QTZ7Tffs1OvyCKJf49UzMNN1T2lov7W2To8oksZ+W
         9UbivHAN7tVrJV4B3z/4uiSvxv2Ml/ErwRnsYweEEkmMI9syo+PX3bOiazEe5bD/geXM
         tKSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794828462; x=1795433262;
        h=references:in-reply-to:cc:to:message-id:date:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5BStpc8jowDmC9B6cxbOb1co1bGTg3WHKFG1Ve9+btE=;
        b=0Lx98NEcorFhl6l2z6O+R1H5hum+tejPRPI+OP6Kst0zhKBxGgjxK6P3rQwZFQ8up+
         1HGt3IRSk4BFVYn8eimGurXhc2f1atccwU2MhvPQgEfi/GDmMvHjooJugh31LS7ctcuR
         5xnVvTGl3yydq9Y3Tc52b4aXKOEz3Kg86n+QeC/yTbZIdgxYXoooTPItxYsybTlbv6xT
         Fxxy89iloERVA8KPl++JTjDDbUZ1+uuXYocdJPueeP0eWSfEXoN7fSQmvgrbFmuhLIj3
         3QMG1+pBJrxCF0IFKg4KlbJo4LLcar8PI7lwyxkudEpN6zDr3B13x7za4zs9EC8VmaWK
         DCTQ==
X-Forwarded-Encrypted: i=1; AL+hErHNRFdpLw0CvoPJ0yISpzkMMDpcoYdpT8z2jPjdK+RgjpWLjs7d5JoIYeFH8Bkr6rlPPRzmpA==@lists.linux.dev
X-Gm-Message-State: APuU4Z9VIgJ5Osiwa7+81lu8H2laS4987DMPGnzIw13myEFQkRMBDXeh
	HxGjkg4nWJf00WC4nRXpb/17Fiiu1+HT71W81RlSZsPWrWFFQpDZOYpi
X-Gm-Gg: AZFdTZezYcUyDprv2ioNkDeT3EsERVO93zoAeoc6Zdb456Eter908rpdot7iXj8HIzN
	gXil2+SpF7oGP0lhq9bCBGm3s5VrvRhjDH0O2C2gGQH/x2C3S5cUqO7uN1J7soQ9Ra3JmE08lpy
	bQr3IkWF6r58q54BOWTiiKjF2CgaqJ4r/XnA4m3slLXE617dLVUJHf0pktxCoPQ0oADOmw48LNH
	NY8YR7zj9mmJC6IejbRupueVI8uUOpdw/vYfn4wb8m+xBp9hzaurq5HgGtxxSLaWP9hdbxvpiWu
	4YymdPV+fTivj3AW/VahOIN4ScqQGnsXzp59zbk/FBugkZMWB8ovUUtwR8MOXpp3uRTnAu6+Kxn
	4M4TGu00ZQUNf77SNx7LyMZ8lKHlRmMrYvW74CsmG5lanDz3UhYkedT2itRCvLLgd0TtBSazZKr
	ERzNFA2l5eujnFwij3okb+ta3FGqEtX31UFSnqk8K+QlIUQvjn7mswB0NzDcO1mZChEg5PzxnSt
	aSf9eRhnlmqPdMTMMNHK0gXqZnI/vtQpXDs+ugbHjpiuCFwhL7Ls/VDOuWC4CjpTjV2IivCSpac
	LlMJxyurF0MDqi9XT3h+1ND+4eIgYToLLeYPk1mJbiYEBH1+shBw3q7nzOpWP3fsOnacn4USe/m
	p0Z+3fxD373qInv2AAzyxqdfXUpdHba0PIT3RCVmbWGBXqjV/Mi+D3PUxsZIvKQ==
X-Received: by 2002:a17:90b:570f:b0:3aa:f2c4:12e9 with SMTP id 98e67ed59e1d1-3b1b0815b4amr10210516a91.3.1794828462318;
        Mon, 16 Nov 2026 03:27:42 -0800 (PST)
Received: from localhost (n106-71-19-159.sun21.vic.optusnet.com.au. [106.71.19.159])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1b3b110c0sm8411247a91.3.2026.11.16.03.27.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 03:27:41 -0800 (PST)
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
Subject: Re: [PATCH v2 0/3] mm/damon/tests: add KUnit coverage for age_ms
 filters
From: Aveline Noir <jm5905938@gmail.com>
Date: Mon, 16 Nov 2026 22:25:52 +1100
Message-Id: <179482835290.151538.5686597403158226303.b4-reply@b4>
To: Jason Angelov <jasonangelov@ucla.edu>
Cc: Andrew Morton <akpm@linux-foundation.org>, damon@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, sashiko-bot@kernel.org, 
 sashiko-reviews@lists.linux.dev, SJ Park <sj@kernel.org>
In-Reply-To: <20261116-test-age-ms-filter-v2-0-3b265d59ec98@ucla.edu>
References: <20261116-test-age-ms-filter-v2-0-3b265d59ec98@ucla.edu>
X-Mailer: b4 0.16.0

Hi Jason,

On Mon, 16 Nov 2026 03:06:20 -0800 Jason Angelov wrote:

> The DAMON core tests do not cover DAMOS_FILTER_TYPE_AGE_MS. Add tests for
> committing valid and invalid age ranges, identifying the filter as
> core-handled, and matching ages at and outside the range boundaries.

LGTM, thanks for adding these tests :)

Reviewed-by: Aveline Noir <jm5905938@gmail.com>

Thanks,
Aveline Noir
