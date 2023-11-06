Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F267929402
	for <damon@lists.linux.dev>; Mon,  6 Nov 2023 16:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yTHaLqLa"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-54394328f65so7788968a12.3
        for <damon@lists.linux.dev>; Mon, 06 Nov 2023 08:23:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699287830; x=1699892630; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=X/OUAVDeDW1FGUoOSfZFrOaeiTbPIasE84BelZaNPzo=;
        b=yTHaLqLaqyBSLJZ/nLUW61nmiCBbMj5ukzNbh2nIAQWPCUGlPMw50wGQu2aETXU+VO
         MBumR+ZNgtuXpLwFkT4kYl3Xw+7ODICIgM6JA0L3219sUEVwxLd+qbIsQeFoigtB/OqW
         PHV5OiB5zzB0RZMYZaV3VzYCjLRTDznEFN19Qqqpom7FM+YGYmLSAlRYBpO+tpKhdFsA
         BRLVn+J4AglP0Zrdw3iDapA3/T/tfMrSNGHjM/JnJ0eAGzPm5ZVdbCpsetTFkSLEmoKs
         L8UGVPWJMfd05lVYR9XLpYVFeeWDudE3g062hiLycBgt+wrV0Yqizq98LUSB42n/458y
         HkSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699287830; x=1699892630;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X/OUAVDeDW1FGUoOSfZFrOaeiTbPIasE84BelZaNPzo=;
        b=e+NhJJw2jxwsZ+SnwG8E+ciK6QwdRwftxeruPjd6wqmUrgMBa/lJwn1xXQCPQqUM6V
         nyms3rZq8pY+LBe//9NfongxCLgQ3cYL1CKSCFp0DO75Ru3xXdF/E6J+mtLpXUDLArzu
         95y024nq0BI6owG5lgJ831FK5c7LafUpzBrsrJ+wflaAPQ/lYZn0eBg39ghjEjMQLdCt
         zirMJg75Jv7rsPB4IH8WgF/YIunslCJ1ceiIpulXBo/jRT0yC6Q3tnChApBhQqLg2mNq
         LxNwxiOM89FXugMUUmIWPw31PU7Rrgk4LBAkrdfu6fHldVjk3B/JqR0LEAhjpI78IGpT
         GAeA==
X-Gm-Message-State: AOJu0YxVnwGmq8oFBBOfXLOrd354eG8ZSzeogiPTM7xjg7s4HdRHEMdQ
	XXNQvbxlCF/AwDM5T0/ZiK8edw==
X-Google-Smtp-Source: AGHT+IG/uWw3t03bxC6ITNHK1stt5SDvYXWCBLutQwdEau303Xm9GJiqyFC6IuLXZUC9vBhJ+bwSYg==
X-Received: by 2002:a50:d781:0:b0:543:cc90:cb8b with SMTP id w1-20020a50d781000000b00543cc90cb8bmr10520995edi.2.1699287830185;
        Mon, 06 Nov 2023 08:23:50 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id eo12-20020a056402530c00b00530a9488623sm4463765edb.46.2023.11.06.08.23.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 08:23:49 -0800 (PST)
Date: Mon, 6 Nov 2023 19:23:47 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, damon@lists.linux.dev,
	linux-mm@kvack.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] mm/damon/sysfs: eliminate potential uninitialized
 variable warning
Message-ID: <18d2f41d-e442-4f73-89f1-50bf20cd85f2@kadam.mountain>
References: <739e6aaf-a634-4e33-98a8-16546379ec9f@moroto.mountain>
 <20231106144137.9772-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231106144137.9772-1-sj@kernel.org>

On Mon, Nov 06, 2023 at 06:41:37AM -0800, SeongJae Park wrote:
> Hi Dan,
> 
> On Mon, 6 Nov 2023 17:07:40 +0300 Dan Carpenter <dan.carpenter@linaro.org> wrote:
> 
> > The "err" variable is not initialized if damon_target_has_pid(ctx) is
> > false and sys_target->regions->nr is zero.
> 
> Thank you for fixing this.  I actually noticed this issue from Coverity Weekly
> Scan of -next tree (CID 1570878), and was about to send very same fix, but you
> were faster :)
> 
> > 
> > Fixes: 0bcd216c4741 ("mm/damon/sysfs: update monitoring target regions for online input commit")
> 
> Cc stable?
> 

The fixes tag is from last week so I assumed it wasn't in stable yet.

Also to be honest, I wasn't totally positive this bug could occur in
real life.

regards,
dan carpenter

