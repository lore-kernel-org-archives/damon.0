Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D0A463A0
	for <damon@lists.linux.dev>; Tue,  7 Nov 2023 03:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TyUISCVy"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-991c786369cso770553266b.1
        for <damon@lists.linux.dev>; Mon, 06 Nov 2023 19:54:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699329246; x=1699934046; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5ohRlubhGgc/ByJJVo91v+dC9pOe3E7CBQIDJq7OEEU=;
        b=TyUISCVyG8NBFK27WmB2IS8t3WlVk1H4kWUwqO0LLNy8nr0KvnIrUWlasS1eyiM4wz
         hL8IqFdrxY3lmPUK9XBAxACkYD8kRM8YPnzSI7RbkjPSN8JFrv5f+vGVfMaScMVptGMY
         MeBW5tI9QOJR5GK0cfA9e+N3OiQFOjnm4C/5LYILPuXEYe01SPfzbVSBWIuuZgI9sJ4S
         kK+2kwOmJiO2AiL8Y+N5RVTnxp8z7QU1HOJ5J48TMsw31nr7z1M3C0XUpm6vjEKgvAQH
         QEtCFYwemQVRdssGysjEpKQ9IdzHujhZGp/AcJgIhSdTcUqJMl5sU+2jgg7sqYswjxQA
         8rKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699329246; x=1699934046;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5ohRlubhGgc/ByJJVo91v+dC9pOe3E7CBQIDJq7OEEU=;
        b=fjazoXciMAxzbJaBrenfvVV/IPjOIpZTK2ws36Y1h347VxSMp6XstRH2veiOk8fYKf
         fQWzf2pPbxnpXZO9535PFd/rRZlJsbqN1OsQB3t9NWeNaVY4FzfoISAv4LFCKcKhnbr5
         Ev+9FR3Qbyu9nk9ovGtPMpdJeg+AHRgFPzypg+x5y3LSFvC99LyTQXqXocekAZY7Tf4d
         Zr6uMF1iP6/+SO/dnz25tyTISgqltdz397pC8DGuuisEuysnalAnR5vYiNdX49KVBhNK
         lmW07Pxfg/3qiT8mQRNl6TLTDzC0r3cfJXV35Y90JZ6QjpH6dMmUMcwxGi51ai9s0sau
         Eg8w==
X-Gm-Message-State: AOJu0YzI8tfMud7l4w/dfMvMlNRHDF4U6ACCICUjwfMa1DfM+PD/R6Tg
	k3xtZDOWOhET9pbZRUUkZwQLuA==
X-Google-Smtp-Source: AGHT+IHRcH59lDrKp36GaSoTXGdBrj80c45Dg5D5kg/o2f2kX1Ge2cCV5nB0wgAbn+E0i3WM9zCrQw==
X-Received: by 2002:a17:906:7305:b0:9bd:931e:30d8 with SMTP id di5-20020a170906730500b009bd931e30d8mr14069528ejc.14.1699329246453;
        Mon, 06 Nov 2023 19:54:06 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id bi19-20020a170906a25300b009adcb6c0f0esm535379ejb.193.2023.11.06.19.54.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 19:54:06 -0800 (PST)
Date: Tue, 7 Nov 2023 06:54:03 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, damon@lists.linux.dev,
	linux-mm@kvack.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] mm/damon/sysfs: eliminate potential uninitialized
 variable warning
Message-ID: <0df4612e-6035-496b-96c4-d790b098aadb@kadam.mountain>
References: <18d2f41d-e442-4f73-89f1-50bf20cd85f2@kadam.mountain>
 <20231106165205.48264-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231106165205.48264-1-sj@kernel.org>

On Mon, Nov 06, 2023 at 04:52:05PM +0000, SeongJae Park wrote:
> But I think the unhandling of the return value is a bug itself, that not making
> system crash like things but might make user confused, so I was preparing a
> followup fix for that, too.  So, though the problem the fixes will fix are not
> significant, I'd prefer merging this and the followup fix to stable trees if
> ok, since those are anyway bug fix, and should be simple to apply.  If
> something conflicts, I will provide backports.

Sounds like a plan.  Thank you for doing this.  :)

regards,
dan carpenter

