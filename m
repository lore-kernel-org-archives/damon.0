Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.171
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793198681;
	b=LMXVyBhQsySri17dlV9PgSw8NrDXk7ep/Onrkg0X3J/4o8A7E3OWxLzy49suHkh+TmIk
	 gK0y5ebLg77EAtMK7ZsIQRA/uaclTT6rsbRWu9h/m3to29Gl+o4YfAw0ICTrmobpu4ZjT
	 ixfPZM76SVHVUVMA5L4weaWuIBvn1HGUmT7YqxGT1LzyCyYR9gKegqt1gVhP8drKZ7KFp
	 QpWzHfOOdGFie0IFsLm/YwaYOvI1el6D2E0U794/0WRAbnafzjChRbuN/xVwTPcUFfZSY
	 W0aSFR9aaqoHlgp4Ck60kurfgd8dSv6pVkKn7f4VynOrwHHct5sERIZQFJFkAFLv26w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793198681;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=P96ClWo1gYeNfWRCa3Ovp0/hmc4uTDQZqSRZRSUUrIw=;
	b=rB7zaCXLcMFK1na/n8rnPEcQZE+cMxalqHu+B6zTWhDPolRCRJlLvI1VhbAIVqTMHhmc
	 JEmkbPbWWdoenx4zTQ4firuWMJLV3/2jKnXzifwSHJdhOa3tZkAW0ptDHwiUtF5DNVyXB
	 IlmSOyetiiWw/I41Q1lBKlBXA7x1iGVsGh6V7aREbyw8wq4qopRe4uVtBrLmpdBH6nzwr
	 gCdmZYpGsmUizfREsArWPrmogNw/8Jx0W3ESQBluYBIsr5i81zl/paehxF+ZQc1+NuGet
	 XFDWCXOyheNjWgpZeaPtQYVel+XCYvClRwQqGPHONeeFrOrCoTYsGpwj6o0h6S98HuA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=C9fKidHN;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.171
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC47606A31D
	for <damon@lists.linux.dev>; Wed, 28 Oct 2026 14:44:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0AC47606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=C9fKidHN
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-8b126b23502so1113967b3.1
        for <damon@lists.linux.dev>; Wed, 28 Oct 2026 07:44:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793198680; cv=none;
        d=google.com; s=arc-20260327;
        b=daPl9XiRM84NLLiOgtFD//7EHQpXSpBW2HpQhL6Fs0G6sVS3mP/6LoNpbPYNxnEx8w
         CZqCE6JJllLLRpttkxQmcTH4gFhNXVMc0VRt/WAww/qn54RATawVi9W7+CfES6MYU9AJ
         vFJZ2xJQU4BojyQbeib17MHrERIqrJyaSTCHvEOFq5+ld5tsBVbacaAjBWeDjnPipjzv
         /A9WImsWqcWq8Ui13ngbWRb7CgYh5XvA1Pb1fEQdsIik2sESof4zA97b1vGBJO2nTy4q
         COsLnqUlF0i7bExLEGRqItVLtGaERPbMrs7rY0MhWpyCRIxrLZjNFsjicF5kj7VMW/l5
         KsiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=P96ClWo1gYeNfWRCa3Ovp0/hmc4uTDQZqSRZRSUUrIw=;
        fh=l2hSYEDqmLaUKInpZgSm36o/wD2nEjPhT0I9hScDhRE=;
        b=MVjmZjUpTu3MJmyrGYU2NSlrcuGmjvyfdVpf5eHbkt6OMV00itvDUUeKmFTk8Btjka
         snHPNXMB5xVmwlE8w5AExGtMAtjPMguKZCOK3Vml+80P7C7BmXNUwuIrsvvN/JN3cCuO
         upOUQAC5LCBJ8EcUk/LpU3xd24jUUA0BTaqGHNl0v7HH6YsGrV/qkfXs+lJJrag/krui
         ztYFgkWnKwQIQQfxyqjH/68RJQ16toZ0U5yE2pUZr6AM2Bsxm12vz0zepe5XdVQTmazO
         tmfUe2mdJ1tqFD3jF0+rQlXvIUcftaxgS3Smn/Ehy3kHUtHX46OrQzfbvcEh5rondcgb
         bKhw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793198680; x=1793803480; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=P96ClWo1gYeNfWRCa3Ovp0/hmc4uTDQZqSRZRSUUrIw=;
        b=C9fKidHN6D7vZfO/E0I9U+i/FUw9VtOxSSB8kQuuYemlrt2AoTG88tD3vKIEuNTNbX
         M5JaMi+rGq5DxX28NogbJhcpUktyNGjBIEYB12mx4hlJ/PfxRgzY21fPo9wtZddv3sCT
         fkhbLcjV1zNVYvl1e0pYE8JajAOGDEtd95fhI3UlJgbuajo4VsOD7/WWMrdULnIapmXg
         ycvMmcGsbPxMDw7ec05Vx6mNyLZIYhY0RkqB+MO2/aXgO/pEAwaLXjKy8lnDlxzbfYdi
         YVorolKYI5qUmIGFZ1phf/YPxxQMCXJrroKHW3SjOLCRXyIDR6pA+hVYAT8nB5nU8tXe
         kbOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793198680; x=1793803480;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=P96ClWo1gYeNfWRCa3Ovp0/hmc4uTDQZqSRZRSUUrIw=;
        b=W47/aJDJW3W5eWO+yvue1Qf1bAEHi7SBymLgTQlYzl2/5PLFc1gc2dnTC62Qaad9Id
         36+/qxBJQhXWuPVclPb2lprUwfxGYSA0ZGb/HEneqfbbh7zDqEJ5j7tipe5aQJMcC5aY
         /gW+e/7TDjBKdXksmsF52cMUxjlw59HNxa7LbU6dgtaseP+Bl+S527HHTAfW7bbRWn7C
         Mu4HEOuxZvCyXjCjSsP+SuEKaeVVr2zNLNlu43ofSC9pAnSlcQFmRI1+GLO7pj5IPWNx
         ap7yqH4Q0Plaix21KbnSEKemwA9MSP3la9ZFrHo1ewl/ZNOKz16nDZ2kdFqDC53bRqyL
         4mjw==
X-Gm-Message-State: AFq9FYIfU1zX4q+VgT/dWRvzbhRJG3arqxbjn93gN6ZatfsGXIwRnhmu
	ijCKZ9BtNyDuOZPKwTniodAftpye3llav7FKBTYuqlaYEB5EWcHLlhcjlOVxv5GYpl85mkH2aK6
	9giPTTpUqivLxqVb+aa3pT8YIkiUQVQA=
X-Gm-Gg: AYBFou2Jg0iYkbI+t7KO/GI2Ig3JlzXh8JzUZf1HcV/oVXbUqb/5WDFYjTZLTVerVAN
	Yb45IWfxkQqwu6KjeuaCrnW7+CBi5eGsqXN/QoiAt36GJK+3ZnQcnm/AWz4udoT7YqZJMalqHqK
	sLzyKVVIsukCqmZTzovyw5ujo7bMqogudo6X19v+AKu7sU/SfOxMKyTVCnI3Hru37EBai/2p2nz
	v3vN2lAsap9uMtDOFy0W9UykXDpiAwNfVlfAxaY8+nsct/ZHopVHgVPxfnJzX2c5KYhkkmFuGmQ
	y+EAymBSah4FiU0rX84JvftpWcEoo98L3ktOTQZMPCyWq3exE1IvfVpofvpLcr+v2DtkIxuPR9z
	+VtJN3C886h6JoXbIo2LTYGybaxR+U28Hbtf9y2wST0TkUE0Yom66eWTg/5xP
X-Received: by 2002:a05:690c:31d:b0:8b0:da84:d1c1 with SMTP id
 00721157ae682-8b1b55a38efmr31184787b3.0.1793198679983; Wed, 28 Oct 2026
 07:44:39 -0700 (PDT)
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <CAMrLSE6ySuzsJJX-KXoeG49pS4ZVbNWZve1dwj1v1avAhHeEdQ@mail.gmail.com>
 <20261028005452.157810-1-sj@kernel.org>
In-Reply-To: <20261028005452.157810-1-sj@kernel.org>
From: CharSyam <charsyam@gmail.com>
Date: Wed, 28 Oct 2026 23:44:28 +0900
X-Gm-Features: AclHuK8HBRkEplDz3YtgZM8eU0XyW1w5JL3yQ9MUiM0uclR1t0d6WB9xW2KIErs
Message-ID: <CAMrLSE7U92fKTBzRYL+hiSMzoMXO2=ZcQYVpV-90CF=193Khpg@mail.gmail.com>
Subject: Re: [PATCH] mm/damon/vaddr: preserve migration weights above UINT_MAX
To: SJ Park <sj@kernel.org>
Cc: damon@lists.linux.dev, linux-mm@kvack.org, akpm@linux-foundation.org, 
	bijantabatab@micron.com, ravis.opensrc@micron.com, bijan311@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hi, SJ

> Even just keeping the current behavior looks not really bad to me, as long as
> it is easy to test and only shoot the foot of users who didn't run test for
> their weird inputs.  We can revisit after a real issue report is delivered.
>
> What do you think?

 I agree. This is a correctness issue, but I am not aware of any
real-world impact,
so I do not think it needs to be fixed now. We can revisit it if a
user reports a problem.

> Please avoid top-posting [1] from the next time.

Sorry about that. I will reply inline from now on.

Thanks,
Daemyung
