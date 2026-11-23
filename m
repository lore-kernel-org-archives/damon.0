Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795455351;
	b=5tUgT3vvsLFPn+/wjPphT60lexiCFQuIGOAvwP3HFixNyGXmhNLFkYQtqHic+k/U9CcA
	 oyVNapk8YUquN5G+ZnJ9qi2wE+tMeTEc1WEfpFgOSE2UGGl/yJzEw0wIiSxZ/cOoz7k5T
	 SKKiUaOiqVXkaz8L9mzBn0capLoltOh/E9vsswzmw8j7j7aK+CyXlxZu8pic/GwYpRILk
	 JoWdTLkQw9qv8iSIYfjBPeeWis+gS8tRfgzJ+LxFTcGwQ/r8yQjuJoL7+mrfnQa/58S+/
	 Bk8hpkN+EWdUWBbPqWktT7P3mTs//l8zo1vYqFh2zmqurSx66uIEBdrUYdI5vkzs8eg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795455351;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:Date:
	 Message-Id:To:Cc:In-Reply-To:References:X-Mailer;
	bh=qEZ/6YgmZAusnYMPizU5ad+3JlJMNNGOuuByXU0MIWo=;
	b=DH2yYIuKYb0j7ZWoJueB4JlFQUxoukhqZ440OWj2P8CGLsXTmDy4ns+MlQij3V3oKAIW
	 5cBPQZclvVdIEY7QQOungjUoaFYjjZHudC10i4X1QAxmmhsvb1UlSmI5r+L/N8eAPjNpY
	 eG/dzlwMVY7ZlaqbpaQYxddfQGrxjKFq4rpKUps9cRHjeKFIn+VnD4fFrkNihnO4l0yAR
	 Arn3f6fjvplImWmCFyjMTvVJSBtFBaFV6V5BxWLPUGeGM8zYsTbbtSKIuwFHuAZ58h0BT
	 nkg0YBak4GOfonK8wd7vajT8HBbgPnqGsr28qApU7CFBqloLU3rsnqQoF6ZuaOlJ9eA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=s1MCtSP0;
	arc=none smtp.remote-ip=74.125.229.9
Received: from mail-dy2-f9.google.com (mail-dy2-f9.google.com [74.125.229.9])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F472606A31E
	for <damon@lists.linux.dev>; Mon, 23 Nov 2026 17:35:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2F472606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=s1MCtSP0
Received: by mail-dy2-f9.google.com with SMTP id 5a478bee46e88-3678f64d078so4258379eec.1
        for <damon@lists.linux.dev>; Mon, 23 Nov 2026 09:35:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795455350; x=1796060150; darn=lists.linux.dev;
        h=references:in-reply-to:cc:to:message-id:date:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=qEZ/6YgmZAusnYMPizU5ad+3JlJMNNGOuuByXU0MIWo=;
        b=s1MCtSP0CgEuiDXwSR7g37jJ4Atpk2DcWwjFZB3IHjuXFhs7NdL7QZ1rFcvbDEOvmr
         Uo9fWu1j5MCDuyM5Q6nVFI9MGbJ8Jz3HXXgQ43ZssRf6/AAueWFa6Z9UIfy+HY/1OXl6
         v6vAr7PgPuEJ179Mb3EC0Bc/3cHwg8Ljkng8+e2YwE/cHRbBe9ATwFPlRWKM+awI58vF
         RQ/V0VXf0RCHotOdw0GJCtNe+F4hOdPMj3wMawuY1RX+//fLyD3y9gEIKceROIrrLBao
         rWh3Hh/ODuMhJ+DA7hrZHBEib35w1TnfRaT52HfaxQ2V3ALhLuXhyKqHfumAw7U5r6ym
         KOOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795455350; x=1796060150;
        h=references:in-reply-to:cc:to:message-id:date:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qEZ/6YgmZAusnYMPizU5ad+3JlJMNNGOuuByXU0MIWo=;
        b=WWhQvP8t74tz9a2tKZY4tKjih9ANBTu1ovPQUIlgq2P+MgQfta9ert5/jsRgfWrayJ
         zUZMsGBhJMthpuqo5BSUzAvchT6G7+wQpA3vUw/qsm+GjcMJjibwXZ9BQfv1XDEQrN5H
         uUiOctTWoBvZjlCZqxd0r4O/XDXTSyIp1orBQIhl4d+6lnEtAJ+qbzPB1Vzps6Uj76xR
         OxFvlc5DyxLLXtfVhBkCKOKikzZGMSY1qC+AqW7B4S6NG9+UxG4oSpQ3/SFRkZ8CtiHb
         /LUZebvWes1QbtT5eiXkpAqrwvvOnMSNZHNE/cgxniNEo69b4zZXe9PsX0LRnIGPm0ZP
         bIBg==
X-Forwarded-Encrypted: i=1; AL+hErEHADF7wB018+C1SHWjybVKlj818amD/BXj7gJZgMKTP7lrILfuY0ntNLc9CjyZLlQPxadRyg==@lists.linux.dev
X-Gm-Message-State: APuU4Z92p5sN0lxicCtnxrbFBcZP3htS26Uc5ulbb/tfab5wOvmK19qu
	9JxjIgEDQAsCf3ncJ2hUVG+rJaScfrz7ZeteiutBHU3ktD90BZaOGFwh
X-Gm-Gg: AZFdTZeYsTGCIVXsCwuF8LwKfNjKi+obCZ/1rGC8xHtOPYIeCBoVrf4JyH8ISpWZcMW
	WqUx44oCHw+3dqKLH3++SIIswV1YR6/+L7QHP5Kr67qkJc94pM7FvCeJscc4f5bkQMmMOUWnBHp
	uGY6xfTqxdP/OMiDzw/Aj4X4G4GL3MiHBqU1pCWEDcEj/qbi9MbfVCIN8Fd9j8imOcDhDeaV0v5
	JJLb81iTZHtAkIrsz5cWBVVjDhYS5cOST57aUEVBrMrzZpgW8xL3cBXOuEiBZUupaK1R/HEvcu0
	muF5kVDmVfCw2UQzH5NOJwofnRjNTimVlkmLsMKVMJFJlxePNT3RvFAq0HeeHf8xLrLLcHxrSIL
	owIYsBk6Y2KmkRSQtdmbByjHHSy2FQNJU+q7hHjp5r3xvPknXf0bH5d0VAuUk69p+CPRccyAJ1I
	fMEoZNA8IgRb+uoc9Zd0+CRq9Y+rZePhnewWV/3Cgpd9j6GIxEnVqekkaVS1w/agGg8OkmP77HK
	2beVv7SyNZ1j/27Di1Cr/YfHY5mrtQ4M/oWHkIm7mD3kjZ2v8/+AV7jbQf3woBjhB5/RPi/eS5F
	IQWeiyXrTGIeMGoJQ+Y7CS4k8pFEqs1HkJttmkuClOtwNznQDOF+N3yaQmGXZNhv1lGQryu8oYa
	QeBUJQGy2qQzK68A4IFQcxHY+5qDFBm1ijBI858hl0fbJDTY+MBUimEgGiX1LFA==
X-Received: by 2002:a05:7300:fe83:b0:386:2184:42a7 with SMTP id 5a478bee46e88-386218445bfmr11662417eec.10.1795455350079;
        Mon, 23 Nov 2026 09:35:50 -0800 (PST)
Received: from localhost (n106-71-19-159.sun21.vic.optusnet.com.au. [106.71.19.159])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38567abb870sm31532302eec.25.2026.11.23.09.35.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 09:35:49 -0800 (PST)
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
Subject: Re: [PATCH 05/27] mm/damon/sysfs: add reports/producers/ directory
From: Aveline Noir <jm5905938@gmail.com>
Date: Tue, 24 Nov 2026 03:49:24 +1100
Message-Id: <179545256499.4.12378392251322743126.b4-reply@b4>
To: SJ Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, damon@lists.linux.dev, 
 Lian Wang <lianux.mm@gmail.com>, linux-mm@kvack.org
In-Reply-To: <20261121210013.130397-6-sj@kernel.org>
References: <20261121210013.130397-1-sj@kernel.org>
 <20261121210013.130397-6-sj@kernel.org>
X-Mailer: b4 0.16.0

Hi SJ,

On Sat, 21 Nov 2026 12:59:49 -0800 SJ Park wrote:

> Add a new sysfs directory, producers/, under reports/ directory.  It is
> a placeholder for files that will be used for controlling DAMON report
> producers.

LGTM, thanks.

Reviewed-by: Aveline Noir <jm5905938@gmail.com>

Thanks,
Aveline Noir
