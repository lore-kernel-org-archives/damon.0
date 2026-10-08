Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB8A35DA4A
	for <damon@lists.linux.dev>; Thu,  8 Oct 2026 16:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791476176; cv=none; b=hkAhoY6YbllKLBfLOYh/C9BCiM9mJkEo8ABmvp0Buo+kj0coCWMA1xboGRqwo9XldNnS2rSfh0fRVhTYLTDkwefxf9lCYOx/taKyr2fDJKrJhnx8qeBQFMeH4+TtcV2JyAgQpopkKeOTDtXfhMwVul1lLKsA46sQVM/GHMUoLNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791476176; c=relaxed/simple;
	bh=+SXhqvCaHZkaVsIx6Mhyugg2UIBvz3lWBqtNEcj28+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pJjpGR9E1a5WNHfx0YVAq7nFO59MYWMrVHZmw1FToRDHwQ+CxrLh+7hNEnmsiIEgZMgyn2wqWfDowVFzLY93NY4xUS8olNH4LH/QXyDPvwaCii2qiAVOgwu3S98DwF4zJc3voCspGH9w8bIvRTqHi5KXZ2ufic2lZzMI/mQMZCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CE+0aBs5; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CE+0aBs5"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3964dfb5a69so2056259a91.1
        for <damon@lists.linux.dev>; Thu, 08 Oct 2026 09:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791476175; x=1792080975; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3vSsBNdAxl9Qjlr79moDpt8SjqsyYJ/CGvS+QG4vQZw=;
        b=CE+0aBs5Kp8h8skRrhRq2u0UFSV7aZQC1wvArXVvNSsGGmvHHyfdClC4x4iYi7/3YE
         IXRkVIbFpTk70vAmkdTPTt4nSiZht60NfXTwin27v48dlWAAZFHcF8EcbomHBUqlfT/2
         NDm7qioORJw26yq2q3XxapWE/EGB5PAXxDFL4m56ksjSdUWyqx+wyOf/fEnIuv/d2Pap
         T4kZqVvj9Db/aqDJRDJEAZUq6GpGyjbeJJAeSsQ+eRWZSlufUdFsJ34lhlpqzw9z5g1L
         EHHICZT0Pzj2ixZIkxwa3RbOs+LANdg554UkiWrb24zSCyET8MapVVNdyO4TL1L7t6DX
         hKrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791476175; x=1792080975;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3vSsBNdAxl9Qjlr79moDpt8SjqsyYJ/CGvS+QG4vQZw=;
        b=B+fSllaYl8yvHrOVq5mA3B99oF0iuhJVDF9LgOg38I734l/pcYhJ0qvA6FIFYkm+/e
         rjxrU7JkdfV+chMZDk7cqCdjYrglveDf5xqd5y8WUwwZIgVWAstI3lTMZHj03rDze9Wv
         36wNTe6F5NZ38ilFXbmGfkOIhdn+sI9QmUNAe/C5U2zZZ/LxAkGkhTpfXKhKzV9ApE1y
         bdczb4pW+k/eHBi3VIbyXzlEh5NesKKOdxVDvWJC9fp/kxrDQFuqeztaGqMv6Obfo9V/
         G5qYQ+ve6CmH70cEgZbRJzpG+kPiRFhzK9SXBkWwA8EqYXgLZ8QYRfu6R17DV77q2fQm
         gk/g==
X-Forwarded-Encrypted: i=1; AKwUvBx2LJSVYA+Jw6/jq3aXuXRAym8GUBsvOiUCHRxXlWTfo9j/6+SKYXfPa7mI0+60hx+XIYCIKQ==@lists.linux.dev
X-Gm-Message-State: AFq9FYJBnkEnpWMDfXXENpUJ0CU/nQIZxkxRXYx4eQK6oVBY1yxaHEl7
	WukY6UPIu7IMaAvNviWlM6YfAxu0e1Qn3SFQgIaCxKg5aKQUtuwAtrRi
X-Gm-Gg: AYBFou0/rDefWReHUXJKIXHHX0ywKK8N1UwN0BW/soZ/eJ80z39sCJUCX3J5HARhe0T
	RhbiCvoeKqCBYM8895OR/z49kPTLzcZ93dLp8SvJv1B01N/aPgRLh4f3AFR2GMFfrzRWsdIDTT3
	yqUzd2Icg7CRfypU5xnMAfh6slYCv0X5bCRBK32jPmueJj58H5rKcEcedfUGUMGj1SIldPqVpSu
	mWoY0JazYRA2qcIWHMTgQU5m82/nVjwUx+sH5RAwBmno3INO8CZlwTTpqrfSSOic1HDvxv1UPhV
	EicEv1wfcPesb1CBTezRwCB6Q6O3e43HP043R0mEs6ysEX7cv5tuEudsGJ9sIPvyUeL/v8e4P77
	inLNZXbQ4UJEUj7kyo2YMvR5QvZyB8XVLpbljUSkXILz5W7HnBfbYUMbox1f61Dy+4HAQNQMeaf
	wBgAflobtvDFRWqfOfOFRvDqkoFmikuEXg18wnAP8NfxivBy6+oTnmst8xbwUrIHOSVn2ZJB+Po
	5w4PsHcLK01dytFUfGMjLzWMA==
X-Received: by 2002:a17:90b:4d88:b0:3a5:c08:4c41 with SMTP id 98e67ed59e1d1-3a8a10774a9mr4496857a91.50.1791476174931;
        Thu, 08 Oct 2026 09:16:14 -0700 (PDT)
Received: from celestia.taila51cc2.ts.net ([2402:1980:8ea:96d7:5eb1:79f7:809d:9087])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a9f1acbd74sm5677545a91.9.2026.10.08.09.16.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 09:16:14 -0700 (PDT)
From: Liew Rui Yan <aethernet65535@gmail.com>
To: SJ Park <sj@kernel.org>
Cc: Liew Rui Yan <aethernet65535@gmail.com>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [RFC] mm/damon/damo: saving damon sysfs configuration
Date: Fri,  9 Oct 2026 00:14:54 +0800
Message-ID: <20261008161621.45669-1-aethernet65535@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261008150043.46530-1-sj@kernel.org>
References: <20261008150043.46530-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 08 Oct 2026 08:00:43 -0700 SJ Park <sj@kernel.org> wrote:

> On Thu,  8 Oct 2026 21:44:19 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:
> 
> > On Thu, 08 Oct 2026 05:32:31 -0700 SJ Park <sj@kernel.org> wrote:
> > 
> > > Hi Liew,
> > > 
> > > On Thu,  8 Oct 2026 20:09:05 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:
> > > 
> > > > Hi SJ,
> > > > 
> > > > Just a reminder, I think you might have missed the question I asked.
> > > 
> > > Could you please clarify what is the question that is not yet answered?
> > 
> > It seems I forgot to ask the question, my apologies.
> 
> No worry!
> 
> > 
> > I would like to ask: after reviewing the reproduction, do you still
> > think this is a real issue?  If so, I will start working on a fix.
> 
> I'm not good at reading the diff in your previous reply.  It makes me difficult
> to understand what the issue is.  So I tried the commands on my system.
> 
> '''
> $ sudo ./damo start
> $ sudo ./damo args damon > damo_args_damon.json
> $ sudo ./damo report damon --json > damo_report_damon.json
> $ sudo ./damo stop
> $ sudo ./damo start --kdamonds damo_args_damon.json
> $ sudo ./damo report damon --json > damo_report_damon_aftr.json
> $ diff -u damo_report_damon.json damo_report_damon_aftr.json
> --- damo_report_damon.json      2026-10-08 07:56:04.979178016 -0700
> +++ damo_report_damon_aftr.json 2026-10-08 07:56:27.717941609 -0700
> @@ -1,7 +1,7 @@
>  [
>      {
>          "state": "on",
> -        "pid": "46402",
> +        "pid": "46449",
>          "refresh_ms": 0,
>          "contexts": [
>              {
> '''
> 
> And still it is unclear what is the problem.  Could I ask your elaboration?

Thank you for testing this!

The reason it did not reproduce is that no DAMOS Schemes were configured
during this test.

This is a bash script for reproduce:

'''
#!/bin/bash

mkdir -p /tmp/config
mkdir -p /tmp/output

./damo args damon \
--kdamond --damon_ctx --ops paddr \
    --monitoring_intervals 5000 100000 1000000 \
    --damon_target --regions 0-4096 \
    --damos_scheme --damos_action lru_deprio \
        --damos_sz_region 4096 max \
        --damos_access_rate 0 max \
        --damos_age 120000000 max \
        --damos_quota_interval 1000 \
        --damos_quota_time 0 \
        --damos_quota_space 16777216 \
        --damos_quota_weights 0 1000 1000 \
> /tmp/config/lru.json

./damo stop
./damo start --kdamonds /tmp/config/lru.json
./damo args damon > /tmp/output/damo_args_damon.json
./damo report damon --json > /tmp/output/damo_report_damon.json
./damo stop
./damo start --kdamonds /tmp/output/damo_args_damon.json
./damo report damon --json > /tmp/output/damo_report_damon_aftr.json
diff -u /tmp/output/damo_report_damon.json /tmp/output/damo_report_damon_aftr.json
./damo stop

rm -r /tmp/config
rm -r /tmp/output
'''

[...]

Best regards,
Rui Yan
