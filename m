Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB0E2F0C48
	for <damon@lists.linux.dev>; Mon, 23 Mar 2026 18:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774291116; cv=none; b=p63eaGQ4sK5KfOZDPn+32rf/eIlz3sxjJvhKXun9w8JdQRJ7CmkoR9le31uaSkJbercRVIjD9LBY3IuE/JEuW+ttRnQK+4mIurDbAdJdIcBE+8vQ+jVzRMPBsccFhku/1m15LRVy9OhcYmRtKg+EF16nI5veEurX9FtdpBzc748=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774291116; c=relaxed/simple;
	bh=vpJkOGpvtoBE0TMzQZPimdI/atrDR1rcpH5hObT3Jgc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cUZbCpbmoXzCA3WeCrA9pHb34psiZh9tW+y96nyarPbTZC481V+C57XpO33pn35DwqC0jjeaYnaMoYsEajNmafxF9LE4EeUCVVb61AkLKKdVxcAvM2+i0OcqCvDgTEMnI22Sq6FzEtyZyquWdiJjpKdcTXtjEKOoxpVrd0E/ljI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fOq2O4B5; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fOq2O4B5"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2aaf43014d0so30346335ad.2
        for <damon@lists.linux.dev>; Mon, 23 Mar 2026 11:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774291114; x=1774895914; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1EkuvjIWUVowxcCQSmc7Xfmxuwhp5n7SrwfXez0NJsU=;
        b=fOq2O4B5WmZV29HqodwONvvL+D3ZUQ6kVxRYCHVoFq1K6bVvP991EO3bmHpRVs2z3U
         iYbEwerDI9FtWO9P2wDu9wsn9tcQhP3KnVq/9SnAHhft9G/1P5obpKXyT5sTGrAlWotK
         uZa0hndO1Kp+zxQHN/aPESxaejETBmj+y0Kw3VsMFFCYaW/GVEmZL8CAaas5cBTa5288
         GpbKZ4lHecMU1xRGIdfNpMA+PrBJAgbVDfG1hmSpmcVeZZLoSeZVlp8OOoKGHEiCoLr+
         90QIvcr85IaFtBu1EwmeUg0J/G+I2VfAm5xb/WhEY+smhXMWFSS7tiEAY+Tab38ZUmY7
         qLoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774291114; x=1774895914;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1EkuvjIWUVowxcCQSmc7Xfmxuwhp5n7SrwfXez0NJsU=;
        b=rRoVvEcZOnBGWlm4TBSmHtA1hwI90WvnlD1pZrdDrzoguQFKtMCmK/jY60CeSMlBdS
         RsAJzLRqGnOhZE5Sit1jef3Kz2gx3/k3C2vLBdUNlxa7k1qzf8sljf2m2EqEhv7hJL/7
         Qcz4rOm9aa4GB8H6pYgi/uF/X5a9LNwUGRQNtCpITda/+D1RkMpQHRsNnLRiH/LX0WDI
         crQ24cHV87NupUU3zJNC7HJhdhmrAu4IpXoEKo/V0PMvnrDny0tWM+W2FqjxayypGoEV
         WcvPzaWnN9sNkztfqXUAsJGQUR+UoGhX6Pt/psG+iyxL4zUw3j2J+nWCT7YUAbY4jEO8
         H1vQ==
X-Forwarded-Encrypted: i=1; AJvYcCUBS2vgyrd5L330S3M8h52kPx4vinLoAvQudonx35rleE4EruO5esepBnz/o2wqxTO5Znfa3g==@lists.linux.dev
X-Gm-Message-State: AOJu0YxFiVtfm5Q9VjtJOTUZmEyv8FjKBMsa8bjf8A5jyyquxrPTjnJT
	353AloKZKHhavDHphJUZU+t02Kz6DeGEVD9nyDsXSkwkE+dtb+GJU5rM
X-Gm-Gg: ATEYQzy8zY0gPiuo7RuDx8B69olys6O3R07zV3lvAI7Y5TurG+wobyoKX4xxDq+d4zH
	QSJdC6rP1893vDDdmDsJwTm/Dp4cQgg3l2uFEe6/o3Llq4ySlMg4HwjCrqRcRb+Zj53cxNk2GV1
	Sj8n/xmK8j5vTArRaqiuwV2AT5yeK81OyEgf+8gUE3KgAOXcG5LoG3R3WEO493EU53/IktwSY9q
	+6kQh3M0vklbKb0lY9WWtuIxclD7kjKi/h7e8B4OE381z4iJ9IPtaT2f5kzQ9f2dt7cY/H+l0W7
	Qe3v0Cw0Dr/QFrKNl0tUl92a/2UmOOAYZTaQJaUmRIuQQjnVIZcMOmlCPCZnaMon7S9o03lUYdZ
	M1AV0ElFrXg9rybnLzzvxsI1dTuAvvwQYBjML5EEpBsnTlHBSeHmTTEj62AEr+xanlWTpWo7XfF
	VkVxE4rfpgDrTBEyaC4G05G1EGcYg=
X-Received: by 2002:a17:903:2fca:b0:2ae:ce8a:9dc5 with SMTP id d9443c01a7336-2b0826f50b4mr71458115ad.13.1774291114265;
        Mon, 23 Mar 2026 11:38:34 -0700 (PDT)
Received: from celestia ([2402:1980:898b:301c:d085:a35:99e7:ffec])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0836556f6sm156153205ad.49.2026.03.23.11.38.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 11:38:33 -0700 (PDT)
From: Liew Rui Yan <aethernet65535@gmail.com>
To: sj@kernel.org
Cc: aethernet65535@gmail.com,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [RFC v4] mm/damon: add synchronous commit for commit_inputs
Date: Tue, 24 Mar 2026 02:38:30 +0800
Message-ID: <20260323183830.42248-1-aethernet65535@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323151611.81358-1-sj@kernel.org>
References: <20260323151611.81358-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> > Hi SeongJae,
> > 
> > Follow-up on my previous email regarding the locking concerns.
> > 
> > > I admit I don't have an elegant solution yet. Here are my current
> > > thought:
> > > 
> > > Add a timeout to wait_for_completion() (e.g.,
> > > wait_for_completion_timeout()), using 'damos_watermarks.interval' as the
> > > upper bound. This prevents indefinite blocking of 'param_lock', though
> > > it still holds the global lock for up to several seconds.
> > 
> > After further analysis, I realized that since both 'commit_inputs' and
> > 'enabled' module parameters are protected by the global 'param_lock',
> > stopping kdamond gracefully (via enabled=N) is serialized with
> > 'commit_inputs' writes. Therefore, a classic deadlock scenario should
> > not occur in normal operation.
> > 
> > However, I'm considering edge cases where kdamond might terminate
> > unexpectedly. In such cases, commit_inputs_store() could hold
> > 'param_lock' indefinitely, blocking other module parameter updates
> > system-wide.
> > 
> > To mitigate this risk defensively, would you accept adding a timeout to
> > wait_for_completion()? This ensures 'param_lock' is eventually released
> > even if kdamond fails unexpectedly.
> > 
> > Please let me know your preference. :>
> 
> As I mentioned on the reply to the original mail of this mail, I think such
> infinite wait will not happen because damon_call() is aware of the kdamond
> stop, and therefore the timeout is not needed.  Please double check and let me
> know if I'm missing something, though, as a reply to my reply.

Yes, you are absolutely right. My concern stemmed from a misconception
that kdamond could be forcibly terminated by userspace signals like
'kill -9'.

I just verified this experimentally in virtme-ng, even 'sudo kill -9
<kdamond_pid>' fails to terminate the kdamond thread. This confirms that
kdamond, asa kthread, must exit gracefully via kthread_stop(), ensuring
the completion will always be signaled.

Thank you for guiding me to verify this. I agree that no additional
timeout is needed.

Best regards,
Rui Yan
