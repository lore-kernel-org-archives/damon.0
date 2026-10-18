Received: from mail-pj2-f6.google.com (mail-pj2-f6.google.com [74.125.227.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0589B3CFF79
	for <damon@lists.linux.dev>; Sun, 18 Oct 2026 17:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792343401; cv=none; b=q2l7h5qD2nfiAmATI83ZYMf8LMvNZAPzGMvI2kVW6cZW4SGzgJoar/MZJIHemHh0VsYVdnUMgmc0FzSH6MkXOWVRwhtWs4+rwfrXWpXeJo9k/WJCDOGgoSxWKSaBnOECHkm74Dq+8X8MOEJ7ChmxFczm0Nz1lQyQ7M7TD2bQsJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792343401; c=relaxed/simple;
	bh=+WJ/hu/3Wga52spo7IQdSXB7WSieQhEpzGVW/oaXQhc=;
	h=From:To:Cc:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Date:Message-ID; b=HGttIJeZhHsYCAJNm72fGpUqIhsfEQVGT1s4YWQ3rkjydr42SSs9B67UrFEALPrw/WUEsi+AD9pkp9OecuEFkyTrxIQWUTBcvRjoWgExSRAOIojBSzef80gFi2vGoxDccx5KdDlk4HWuAOr2I4Hyni8nhlsX97aZhIAK9oM0Zt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JLZ5fybS; arc=none smtp.client-ip=74.125.227.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JLZ5fybS"
Received: by mail-pj2-f6.google.com with SMTP id 98e67ed59e1d1-3ad211ad92bso233111a91.1
        for <damon@lists.linux.dev>; Sun, 18 Oct 2026 10:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792343399; x=1792948199; darn=lists.linux.dev;
        h=message-id:date:content-transfer-encoding:content-type:mime-version
         :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+WJ/hu/3Wga52spo7IQdSXB7WSieQhEpzGVW/oaXQhc=;
        b=JLZ5fybSs4doB6bMRXOA/O9F70M9BJNVL5KibEsZiK9iV0xs6tRaqKXSmp1N/Ng3NC
         A1PXy+yYep4xLyew7p31mmux5bb/FW0bo5TPFwGHzuG4xi0u33FkhdfNOQJIBQuoPMra
         4NGEf9eJ/QIX+/gLqi3+ptSTX30ChyDOFAGUpLgcHCMHM7yB6uN++RYpC+tPSLT73PjM
         3YWBxNY97qj9J0c8Hwh7Ss7mVRqiokS8IoFUYi0ENZERn665GtMHPp3T6s8nlyC28QSD
         mhxr5eE/nT75LxpxS7vLHnpGdMRfmEMpJjXciN2TscEP8236175aFcL5XGj+sOrDiMop
         hlhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792343399; x=1792948199;
        h=message-id:date:content-transfer-encoding:content-type:mime-version
         :references:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+WJ/hu/3Wga52spo7IQdSXB7WSieQhEpzGVW/oaXQhc=;
        b=eRmgONS3r9WyC7UOSzzDi3brs6qsLlWWPq6ZxkAUgo2Kp8jb/gY4nJl/k94m9TXOpD
         6QO+2dfuuheY87zXNBkIwAhHXRhK6rDPYM/RTnJRkslTTpG8Qb1EOS5d4iwayv9hTAHA
         xss1/2ZO5DENuERcjl55cQkWZ1V+sYJbLu9pk4dP6nbV21eNXyDn2igEMGeHG08Q8EoY
         Yrcjlnp7DKQ/ZBw6sYa4HTzwJBfUric7LkM+y1h9AEl/XJcxhESmJOK73TTj90Evb2x9
         Da4aPYtL/JIWaiZ/LL30RpTDe6BunOt6jiUJvi4XRTrOY7rywhl03Wvvd7zYW5Ldem/K
         DvZA==
X-Forwarded-Encrypted: i=1; AKwUvByTigi2TpiEiqh37kIDOO4BQ4tvbF+Uz5DU2EtFGwMdcXJsZwr5QT9/m1s5SIaLDyCKl40m3g==@lists.linux.dev
X-Gm-Message-State: AFq9FYIpfAheqnScS7mr62wGrobPzUf0uJKSUZ5LJOp7/5wEpd3X5X/i
	YOdAuWH9B6cqamSgZCESgusZ7PEXq50gGV+Yypb9NnF8A+jW5+mu5AMiCa8oIA1uQTYguCbX
X-Gm-Gg: AYBFou3gMoG98E5eo+Wz222Djo8VbWglcftJBnY2Ni8xS+lu3zZUHLX/qR3QtzvrDEU
	JwKviRECSUQ2Dyr3bVIOUsAgO0zCb1ZRp1rUtDwcuA1HN4znAk3dVXAyXt+XfZ2wIUh6FDrFVD6
	Jhk4x2O9aZJXINM5jCCGODIdp/hgcsvjafmqyxvWINmNVs6vhtNTGf+yuh2CYa8p5/2AyAiXffZ
	XCpaRzvEYs1IU0E5p4IPbr6WfsG7ku7Nd6//fY4Oxz29xbCcu7QpJjC01LrWnUL2q+8ohiGdAJL
	616QCgHiHqPqwN2yt2OVp7GtFDSxFPNPUWmdOuhWntPV0c+VGr3tBcpN4hHKp0nRd/2x/Tag2ET
	Yr8bZXTPenQvnqkr5gMh+/1hoSIHmDwj/6AUE6OfpnAisPTIpR/9CdYpIFjn4q95b7Ywx6KHG7G
	0UwurWX0dgeYfDToPKiqz8P3S7sqysi3jjstJA5+tjV1M4nk4CYCRHpWWCoBqosL5gmhMNe5m31
	8EPZKenEVkk2N0XI04tjH707XHfNoW+DWWPvsHBEjam/hppja8KjmkdUm11qvwPCkUdCgCdAeAZ
	W+I=
X-Received: by 2002:a17:90b:57c3:b0:3ac:8ee5:e007 with SMTP id 98e67ed59e1d1-3aceec24801mr4102774a91.20.1792343399360;
        Sun, 18 Oct 2026 10:09:59 -0700 (PDT)
Received: from [10.20.15.86] (n106-71-19-159.sun21.vic.optusnet.com.au. [106.71.19.159])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac94798212sm17396301a91.14.2026.10.18.10.09.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 10:09:59 -0700 (PDT)
From: Aveline Noir <jm5905938@gmail.com>
To: Jaeyeon Lee <jaeyeon.lee.dev@gmail.com>
Cc: SJ Park <sj@kernel.org>, Shuah Khan <shuah@kernel.org>,
 damon@lists.linux.dev, linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/damon/sysfs.py: stop obsolete_target shells
 hanging the test
In-Reply-To: <20261018020415.35567-1-jaeyeon.lee.dev@gmail.com>
References: <20261018020415.35567-1-jaeyeon.lee.dev@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Date: Mon, 19 Oct 2026 01:09:02 +0800
Message-ID: <179234334286.2.7819752603607417566.damon-sysfs-tested@gmail.com>

Hi Jaeyeon,

> Fix this by passing stdin=subprocess.PIPE when spawning the processes.

Tested on x86-64 KVM, works fine.

Tested-by: Aveline Noir <jm5905938@gmail.com>

Thanks,
Aveline Noir
