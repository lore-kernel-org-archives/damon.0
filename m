Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71AF521CC5A
	for <damon@lists.linux.dev>; Thu, 19 Mar 2026 08:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773909408; cv=none; b=mkZwGrk/45IZ/RT5DA5KNmXREEBW99dup5MmKk+2VnGCYA4HaoBoSqmhk3RkGesqK76Q6pphI/2el7OvnAKN8p2ZvgYSSmaJWbcjuQ4vRjxqANvlRheoq8OKUjFzsOiqXF5m5Wcyb1vBm+IDDMTCo+WfieBMhZEdoTE5u9NWh34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773909408; c=relaxed/simple;
	bh=oYqRFVlngihEUTVmTogP2RPUetAon3C5zF366GdZOj4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sL2uDJU8Ig7C5V452iB3/bveh4uYtcQEK6RAQPOK/JUoHRSQM9tXwEwh9A/y/CKSTHUGrmQC/wjxINPpbxh8eIMDP7wtThM2qO8XKP48LkqJJ2J0Jx0iXChqUbeymXboo7JjxFHzW2e2l4j5lC6Ph/Co6oB6468xAOiuGq+FkwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WecN9BV/; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WecN9BV/"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-35bb9070644so397247a91.2
        for <damon@lists.linux.dev>; Thu, 19 Mar 2026 01:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773909406; x=1774514206; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IwV7GqDEI38/m1BvpkV5+1r1843ywx8ur1qd4Lt12Bc=;
        b=WecN9BV/EpYST0+cwEQoIyw1PvC9cvleAaRFgpAx3wwzzF/RL3ajcK9Hk9KEtkwGpY
         jUpxbBcMuavSnZiLrA6CvledXj5S2uDWhOpCGpJPNsFW39xFX4bZUYZ5SdTw989dp3aZ
         kmvPF5VZquwVYXtWefWkdn9DDlicfQBRdmeE0ebjlWMNOPYlYIUWu2tEWR4sCvfTXZyQ
         ByOUI0/P5el7c3c8HyKASggQbCv8f4nQ0K0gXxYMcLoUqTAXSrf1IvlU/Kjf4jIbCskZ
         K85sBM62rJsbhFM5Hg37lvJxuhd6/0g8Y1Ak9RwFrHDDVepC8S+eTSrpXTdAaH+ydxwD
         j/mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773909406; x=1774514206;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IwV7GqDEI38/m1BvpkV5+1r1843ywx8ur1qd4Lt12Bc=;
        b=YSRZ6zM4ftutmyfkUI/2X1MCjuImiiTPxsy5yX46D/q2LfXtXVn9oT93SC1ZAa1S/1
         MAZMRjwSlmZnlA15bqx9rAJ4/2ySn6sv4dgT1JNgoeNYe8XbhG5AOcZ7vS5f8BZmaUX+
         jGIH8rZykCe6HijDjgBlTNik9VlcovpdY+8/HswaczJyX6Yk+3VjOu39CnR7JLR52eMZ
         ymqx2e60CPF8v+NXB4OqJ97MIIxYcLWRbvoFZmxiQDmOmok0XNetih9IjjNX3gq31Lf9
         5TE3JgTECPLsFw8BAC3LQGLWrghMnAEEhu4ISperP69kzYuK97ALZvO7zH3B5N7Y/iP6
         1GZw==
X-Forwarded-Encrypted: i=1; AJvYcCXCJw+HEC6KCH9TlsIomMfB/dCipuB1NIDn7Eiu5ueLEf8npAVP2yST8xcEagzmHfkRcW2ukg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyPsZ7AcXOyFijeD+IuLC7ZKyqgEEfmWMRM9aOfc5JoOk4acCXD
	r8YiSJ9Y7voV5AEQhktNwpHuEXmkP5u4MOuhRVzAUMinkRisiJayobag
X-Gm-Gg: ATEYQzzUwY7nCJukhZ4TNvfX80wFinaLRPkuyDS4Pba7dpnLFAwsrjLKcX2VsTg+DTn
	hobN3pBBZJhj0LwGbX2+JT/vgieuikGvRmoZu7Bui5Sk9Ln16f2Fe80sJ5x1UsvvOOux/9J8Iaz
	xGW6oE5seNwFtOm4ocuh6c/y+3ETflN47BeL6Wkedog702YKzNsQPJgYmxdCnvnqTiFtU7597Qr
	BhgTr29vBcRlQ0EOgkf9CMNvn+4+mRC40u5v92w7LliAY3jgUMg9MF0STMeamUDXVstMuC2pbt3
	DtrLzG/xpgTOMUE3Bn9k5kKzHnTL+CJaGwIWYqLOsZjunc2l5vhC43NhKWan6xfqxr3opKEh9wq
	XnXYJkdGqn6mUEFFBaGpWSYFcaxuu/QJWyxQbu6a9kTPcpPKWEsJSpcn/K2iQfEmxg+1VUxykQC
	i+CCCQYiULQWp4W+2rMPMgoF0LI8O9S7/poWVWq5umne7xbOieSyI=
X-Received: by 2002:a17:90b:5350:b0:35b:9c97:3d18 with SMTP id 98e67ed59e1d1-35bb9e514c5mr5668061a91.12.1773909406429;
        Thu, 19 Mar 2026 01:36:46 -0700 (PDT)
Received: from celestia.taila51cc2.ts.net ([2402:1980:898b:301c:d085:a35:99e7:ffec])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35bbae5e19asm1695794a91.7.2026.03.19.01.36.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 01:36:45 -0700 (PDT)
From: Liew Rui Yan <aethernet65535@gmail.com>
To: sj@kernel.org
Cc: aethernet65535@gmail.com,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [Question] mm/damon: min_nr_regions constraint and inconsistent error handling
Date: Thu, 19 Mar 2026 16:36:39 +0800
Message-ID: <20260319083639.36440-1-aethernet65535@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260319014624.97146-1-sj@kernel.org>
References: <20260319014624.97146-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, Mar 19, 2026 at 9:46 AM SeongJae Park <sj@kernel.org> wrote:

> Hi Liew,

Hi SeongJae,

> The initial version of DAMON was supporting only 'vaddr' operation set.  And
> 'vaddr' is designed to have at least three regions, for the two large unmapped
> areas on normal virtual address spaces.  Hence we enforced min_nr_regions to be
> three or larger.

Thanks for your explanation! It makes perfect sense.

> Yes, I think this is a nice idea.  Maybe adding a comment on damon_set_attrs(),
> or additional sentences to 'Monitoring' section of design.rst [2] would be
> appropriate.

Agreed. I will try to figure out which method is better, and I might
send out a patch in the near future.

> I'd like to be cautious about adding logging, as it might be a spam.  I'd
> prefer making it documented well.  Then, users could find what is wrong.

I see. I understand your concern about log spam, I will focus on
documentation.

> I believe the above command should returned an error.  If not, please let me
> know.

I re-tested it on v7.0-rc4 and it did NOT return any error when writing
'Y' to 'commit_inputs' with an invalid 'min_nr_regions=1'.

This might be unintended. Here is the full log of my session:

    [root@virtme-ng x86_64]# cd /sys/module/damon_lru_sort/parameters/
    [root@virtme-ng parameters]# cat enabled 
    N
    [root@virtme-ng parameters]# echo 65535 > max_nr_regions
    [root@virtme-ng parameters]# echo 3 > min_nr_regions 
    [root@virtme-ng parameters]# echo Y > enabled 
    [root@virtme-ng parameters]# cat kdamond_pid 
    89
    [root@virtme-ng parameters]# echo 1 > min_nr_regions 
    [root@virtme-ng parameters]# echo Y > commit_inputs 
    [root@virtme-ng parameters]# cat kdamond_pid 
    89
    [root@virtme-ng parameters]# cat enabled 
    Y
    [root@virtme-ng parameters]# ps aux | rg "kdamond" | rg -v "rg"
    root        89  0.0  0.0      0     0 ?        I    10:15   0:00 [kdamond.0]

> Also, if you know users who depend on the old behavior and therefore hoping the
> old behavior back, please let me know.

I don't know of anyone who depends on the old behavior.
I am a student exploring the kernel (DAMON) as a hobby, so my
perspective is limited to individual research rather than large-scale
production environments. However, the current behavior (staying alive
with valid params) feels much more sensible to me. But it should return
an error when 'commit_inputs=Y'.

---

Plan
====
Based on our discussion, my current plan is to:
1. Document the 'min_nr_regions' constraint in admin-guide.
2. Add the design rationale for the "at least 3 regions" rule in
   design.rst.
3. Remove the outdated sentences claiming DAMON will disable itself on
   invalid parameters input.
4. Investigate and try to fix the missing error return for
   'commit_inputs'.

Does this plan cover everything you'd expect?

Best regards,
Rui Yan

[...]
