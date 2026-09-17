Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 423394E01E6
	for <damon@lists.linux.dev>; Thu, 17 Sep 2026 15:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789659156; cv=none; b=mTnBu8QMNWebC+zrB1/ThRWylk9+9tb5eQToZBNQjr/zTVhCFg9UWRICuwzF1CMCH7l4oMGcrpSVxntbAS3D1zYkkfTOpL3f/f7OmXAF4TUMLrGPhQBVVsQVbz1lIZ0SdoeaCiN5Baakaxi6Rl2YUEvZ7Dw7xsxFVskdHTy8GZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789659156; c=relaxed/simple;
	bh=qtwIrKO5cTqdysBV4bOj9NPJpTUBjTxYcqUGkueOCZM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KtvtIcB+NwxQmPMsqMns6MbrM+zbqhmQIVk9JrD/gMOIEUxapUcvrWnN5cSlmXc01e6VGYYwWcfB+NCbQuduflOK05hp8aTnPBha0hdL194075l/d4CCVRZWwSemWmwgVdggYic9pyX2NDBL2xWTITOYRwRKkZ0YQqdHpM8q1Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EhplHvoF; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EhplHvoF"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-39b910bdf2eso696114a91.2
        for <damon@lists.linux.dev>; Thu, 17 Sep 2026 08:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789659146; x=1790263946; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9o+h5h/Is4Nwey7TzHWzFOTMN7qfm8CQCTarqUGlzGE=;
        b=EhplHvoFvl7AE7dOLHKpiHBH3Nje09U6bDdnve2/LrcGLrMMb61YatFFZkl9GOss2B
         Xbf+3XsgQd64461J7d29J50oXVkBJea4GkCgWntVIi1kaHk9T4X8p9n6tDtC/Jd+1qsk
         P6D8k6Pk8G/7cgiy/6uZxXzxD2zFoZiElBBZv1uw7gQMp5vzd7kJxn4rTFE0cflFqW5h
         Bg+6vSw1EDI/UzIXodANrcvHaQygaxSE8NTiTvYl5Z9/TOCuyPtCULAM8f0xxl7cAgv/
         NzRz4ub5FtyZzTvDy6voBuF2YFai7M53MiKUqadts/I6U2PfcgvL2YTkCvdMl34WGMRf
         8+Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789659146; x=1790263946;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9o+h5h/Is4Nwey7TzHWzFOTMN7qfm8CQCTarqUGlzGE=;
        b=LXvW2mtPZIz8S+A2b9ROQwjLqcpXuiTWQhU6XDFP0qw43X6w8F6j6nKV5ltCV121iB
         BSuyIIQGjsEJide1jKdDey/HhwJZDYJJtEdLTUOwDqnxXmoBjSNxifRqUzDygcYc3l1s
         8cbTGXUflFhV2R6JMuwjNC+nFcscYgINQPnE8hXLDaFa6PROY3ZH90cYGYUZO9YuveQ5
         CXFxcPSdKw0dBQOvBG43DiB76xJOOAWTiKp726sHMTficUMSuWRX6bvm/eh0Iku7cvYh
         uxc8hvPYzr4cAOE+bL8a89rmJ0N45UAP6YdW6ftszyakIKiG4wSHTFdCaHs/0uAqWDYT
         Tgxw==
X-Forwarded-Encrypted: i=1; AKwUvBxLExG46oRA4gJl+zpcFAD8wjFnX5zvZ9m+OAbX6rz4oIxgtPTsvCj1VAljRK/BawNt2vgolw==@lists.linux.dev
X-Gm-Message-State: AFuF++l170J6c79U8Skm5GfM2i/6cHIE2J5rxfUXO2PDuLjIT/o+rrAo
	IAg/Jo6pzpyJx6xP2Tl0nn1bTNqyVUMvgMuFuK4GjAn39vnA/db9MUy2
X-Gm-Gg: AYBFou29vAh6v4odNO1o7Zdplczx7FoirxAHaSZVB42Qf8bCNvYGhDBC1Ag2VjxX3W+
	7zO7mPez+VrUTVrNwRrhvfl6eTzNG0Wtdv8QKfThbQIxN2pCVajnweV9tnQQNMEkez0tQSoLy8G
	ubsGCbaXC17ATUqKfiMOT78u8i0nQ3pw5DknsdotzLOMIGEw8bSHbG9YkQZIPXZG+nSZ2fxso1/
	pmLpOFibR9k19nXavyGLEn76xg6KKWRdfdVEWDxM4bhUuFCVaTr2qT4A+Q1xfBb8n+wXlPfIzQj
	Fj8GOkpnIxp43TLv13ObaW7rkZ2lB2PKWAwrQ+L49bn4Lc/66tN1hRTLBxzAOia4W8DUPqRWox7
	lSbOGrxxISfsYRZUNVofUxEM+AfZzhXSdLbe77xXxDPCGRE51zSv5sjNuOBl7IBY/67gOmodwPO
	k6GjDwp75y9ngpK1kedl/+YhVx//mPMjPbOZxJSpxcIw7fbF7tVKRl6GOkgnQ/OaFEhQLHBYJtN
	rM=
X-Received: by 2002:a17:90b:4cc8:b0:398:c292:ac80 with SMTP id 98e67ed59e1d1-39e1e330a2dmr17225810a91.10.1789659146260;
        Thu, 17 Sep 2026 08:32:26 -0700 (PDT)
Received: from celestia ([2402:1980:c3f:8e4f:9945:ef6a:453a:80bc])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e35def1f2sm5655462a91.5.2026.09.17.08.32.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 08:32:25 -0700 (PDT)
From: Liew Rui Yan <aethernet65535@gmail.com>
To: sj@kernel.org
Cc: aethernet65535@gmail.com,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [RFC/Discussion] mm/damon: Implementation for paused kdamond
Date: Thu, 17 Sep 2026 23:31:53 +0800
Message-ID: <20260917153238.76020-1-aethernet65535@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260915002836.101895-1-sj@kernel.org>
References: <20260915002836.101895-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 14 Sep 2026 17:28:35 -0700 SJ Park <sj@kernel.org> wrote:

> On Mon, 14 Sep 2026 23:35:10 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:
> 
> > Hi SJ,
> > 
> > I noticed that the current implementation for paused kdamond is
> > periodically applies online parameter updates by kdamond_usleep().
> > 
> > I'd like to know if we should change it to waitqueue to achieve a lower
> > power consumption?
> 
> I'd like to make a data driven decision :)
> 
> > 
> > Previous Discussion
> > ===================
> > 
> > I noticed that when you introduced ctx->pause [1], Sashiko asked the
> > same question, and your response at the time was:
> > 
> >     "sample internval is 5ms by default and recommended auto-tuning
> >     setup makes it hundreds of milliseconds.  So I don't think such
> >     change is required."
> > 
> > I'm curious that, did you think it wasn't neccessary to change it to
> > waitqueue when it was introduced, or it wasn't neccessary to do so even
> > after it had been introduced?
> 
> I guess I thought so when the quiestion is raised.
> 
> > 
> > Asussmption
> > ===========
> > 
> > This is just my assumption, not a real use case I knew:  When 'pause' is
> > set on an Android device, user might want DAMON to stop running
> > completely when the screen is off, thereby reducing the load on the CPU
> > without losing important information such as regions and age.
> > 
> > The current polling may make it harder for the phone to enter idle mode,
> > resulting in some unnecessary power consumption.
> > 
> > However, pause feature is only present in the stable version v7.2 or
> > higher, and since the latest Android kernel is 6.18, this highly
> > unlikely will affect any Android users.
> 
> If whoever comes with a data that require changes, we can discuss.

Thank you for your clarify.

I recently backported the pause feature to my phone.  However, due to
Android's screen-off mechanisms, I wasn't able to obtain any valid data
during testing.

Since we haven't identified any practical issues with the existing pause
feature, switching to waitqueue isn't neccessary at this time.

Regarding the documentation, should we explicitly explain the
relationship between 'pause' and sample_interval in the documentation?
That way, users can adjust the sample_interval value when using pause
feature based on their specific use case.

> 
> > 
> > [1] https://lore.kernel.org/damon/20260321202858.98091-1-sj@kernel.org

Best regards,
Rui Yan
