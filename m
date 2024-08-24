Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A174142A97
	for <damon@lists.linux.dev>; Sat, 24 Aug 2024 17:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724520376; cv=none; b=Wd3UmFJQBgDKjnCYgqpfb4L+XR2zQcESxpVPJXPOjMzw3ipBCTCyP3Vt/BwMyToPWg6OgAAOBDT2N7MhmdxO5YCPSnPO8HvA+F0TP53oiG5iNDgCqoM0Tx5l4+8NSxY2sJCjZnM+99zhg5cioLcGdSiRdflp/iilQ+Wi8vD7/L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724520376; c=relaxed/simple;
	bh=+klTtOaxzSCfE3uUpW74cWNQDK1+OU78TMXzAGbe9nc=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=QdaSpOZ31e47SPwA5Uw7RbqKmXcG4GlU7Vnrlrofy/GqNBq0QTuYlECQS/KXoXMeETfsR4GfRwvmUXXmRfJrWtKC3tDRp33UHF2Uta7mzl68kmNLk1Urc8K5Qhi6JAY4c5udwG5gXIimSrzMr1o6MwVAJoZ3TZIUA5OTTqJnbjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D9fwoF76; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D9fwoF76"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-7c3d415f85eso452446a12.0
        for <damon@lists.linux.dev>; Sat, 24 Aug 2024 10:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724520375; x=1725125175; darn=lists.linux.dev;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+klTtOaxzSCfE3uUpW74cWNQDK1+OU78TMXzAGbe9nc=;
        b=D9fwoF761Mc5iqKw6DGlCWK1VwXt/n8z1gosTgezCh2wzmg6nrtT/AoGfNHkkXdwyN
         K+LX58a28yfDoDd96rvHf/qEqvtytPzJijggg2lv/qIwCeKYiI0HDGpSqhu4bCkn7xi2
         lmxOAxjODyQbpb2U1h3jxWX9CnRUiCsurvLMJFJ9fEbXvtiGOygcYFbXxzrTkbRb+N8s
         IL05ojcnKvr/enwIB987JF8f9Q6Vz0Axx25HfAYJMX3kHsCW8b9qBrg/A0l1QXJ1lDWo
         9G8SoJSrHzuh9h8GZo/Zs/XxWDYQX95M6Fi0HAHyOsxwDuslb6krQEaTMiMGzl4uI09K
         N9IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724520375; x=1725125175;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+klTtOaxzSCfE3uUpW74cWNQDK1+OU78TMXzAGbe9nc=;
        b=RLf3khcsI0jT4lknbnBQpnfVvJ+bwbUxyKJ/AAoRpPY2gbF3rc7Kp/4hCMbG9f0ksq
         rtU0pf/mQZRbb2MPF/UeCVrvdUVjHxEWKDQLP0OO9U+jGBy4o8o//eptpu+Sf5W12rak
         pF8UmVN1GPtO7kccOFhBPUhQl+H8muVg5YUqNEy+lyH9G9m+UcEE2QPSxsD4tYXXQVp6
         RVLeyZgK15asvxfpJPeFt6IJGKXbim7n/JsMOc/XmgvQgwPWQwpGpUtTfoOUKpcHRQa+
         8zvD74WtfoioSIbrdD4mlVXNQHw9k42RSqrsoWXw5O9/etznanbdLvTS6XwQ+TMLngA2
         YQGg==
X-Forwarded-Encrypted: i=1; AJvYcCVuZX1u73UkI6sQIgZYGeYEs0XkzbFWxb4V6yyG2kc4CiHHGKAXr9dq+/PQoOh1ArHrE6sZpA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyfeL3/HwynrT19/VBNqBl9lSkYHiU8/dFaGf+tHEJECK9AtSRD
	GDf9lK9+NxipkvMAIcaqDPz28RopULjTmlt4vdTIrLVhCrOjjUDE
X-Google-Smtp-Source: AGHT+IH4y8YoixXjfQsjKAp5ZAkJC8wibI9YyJ0SVmuJae7rrDHkmW8s6pA+QQlHtjPutPdTPW0Ljw==
X-Received: by 2002:a17:90b:2e83:b0:2d3:c2a3:2383 with SMTP id 98e67ed59e1d1-2d6465fad68mr3980264a91.0.1724520374617;
        Sat, 24 Aug 2024 10:26:14 -0700 (PDT)
Received: from [192.168.50.95] ([118.32.98.101])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d613a7384fsm6401504a91.34.2024.08.24.10.26.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Aug 2024 10:26:14 -0700 (PDT)
Message-ID: <170c9341-2cd2-48f5-97cf-66ca059a5d66@gmail.com>
Date: Sun, 25 Aug 2024 02:26:11 +0900
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: SeongJae Park <sj@kernel.org>
Cc: michel@michel-slm.name, damon@lists.linux.dev
From: Yunseong Kim <yskelg@gmail.com>
Subject: debian/config: add DAMON support for debian kernel
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi SeongJae,

I have submitted a patch to the Debian Linux kernel team as follows:
Link: https://salsa.debian.org/kernel-team/linux/-/merge_requests/1172/diffs?commit_id=1c5f4aefc7791367bbf43adcd81594d1cb42aa66

Please let me know if there are any additional details or improvements needed for my patch.

Thank you!

Sincerely,
Yunseong Kim


