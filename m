Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6998E2517A5
	for <damon@lists.linux.dev>; Mon,  7 Sep 2026 02:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788748048; cv=none; b=FV8oRTC+Ki6DUUFxVPFSk0xp7Jl+GppFKtGQUa97fm+oNFdzpu2lOUEHYceDdneKhXKaAv7QjS+Dpx0LZoxVhNr+sdFeZ7qUY+F53sxl5NU/lSDrxAVYx1OSDSJPl5M0psDDz5Q7RYCv1rIMXc7lUy9wJ/Urr9uwHy+R2QsHfJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788748048; c=relaxed/simple;
	bh=rP1oA0DxmfD1YAjhh15xGLfb3DU+susYyuxibGkWvEI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oV+E2EbvPJX6qftWZjeHPS20uh3BtWJQNgOlpKm8vbE/iY7idAsdI+KYdY0K951xUSHK2l6g1wl7HPTvOU4in5DnVBy9eba2Ox3+GsuyBUwSD+sUa/rqejTOWwzr1eN61mninE/9tMkG9yuRpG2yGWPoPFNmFn9IH6yvzjoLrcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DitCSIOB; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DitCSIOB"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-39b24d114d4so3053263a91.3
        for <damon@lists.linux.dev>; Sun, 06 Sep 2026 19:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788748046; x=1789352846; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=hK6rznH6sZmMYoIVp7jSpppx7B+6EUkEUbPHQbE9BCY=;
        b=DitCSIOBdxqn2+fgoNH5EQ1OqghGrA3BRX50qcKbA0XSPIGQKS91qjRLkGDfYVpRDY
         nkP5d3d9ORTqeQp4efoTg2it/PNZZfCAKB94oTTgxe7P/pMl7deVJUKfeF+eju2veKTZ
         LCLN4tEyeP7SLtihinWNmInrlmw4Ygj31ptnYs4NVmyw0qEW2f+wMxuK2zCE3PIl5OmC
         paIXZbc7ZSSBQfItI3WY2fjQgIVEByM5skWijt0Yka/rgttuZFNX2DT5c61hc1jUCj9i
         eX+NLE17Mo/tWIPONlY/pe14qLkrKxKbLGvh6oSWB0DmFawPkBXW3kO38t9FWrQmrm04
         po4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788748046; x=1789352846;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hK6rznH6sZmMYoIVp7jSpppx7B+6EUkEUbPHQbE9BCY=;
        b=OGSH5ygW7MSyhpfeWyCeGutF7NgpO+cfA4RUSHlcU8h40oY73GFM7DqoOVFYDETbjw
         Am51dX7htm0S60o2+vOzYEKdok1/jdPcqRWMYuKrIud8YsftiV7roBtqXd4t8AhH3beh
         2ihIHmLkTNLHiZ9YteOnVk5HLK8qIytIPgMzJ15+OXvTUO5nhBDWGrRqbb2lMXk5Lp8O
         YBQ2oWR4daiwdQM05q0pWT5kr6uzenOfueDT8EhzxaUkqGYs4m3f3KRErc/1ai9i1BC7
         NCrIJLw9BnMeQZ8S1sfCTPJEvPnIhXUv4Eo4VDEbghyiYK5KYpNRjWfhh7valmDViCRi
         BGsg==
X-Forwarded-Encrypted: i=1; AKwUvBwIiczjmMTXviJqdnJfv+SCdLN2xtPXErBIIQMtvOR6djObVWsuAMG960i3/HAzseLT8s/25g==@lists.linux.dev
X-Gm-Message-State: AFuF++kBIsAxpjDpsw94alF8H4FyC8/nJ4SLl2ynLamoOdB+VaFQTzKg
	zNWWpVhVOCeyi/8CU6nwyvu155YEisffmod1Nd0Epsm+45DrelM+EnGT
X-Gm-Gg: AYBFou09ViS3xTAk2dXNXlYdbiWjht3Dw6U6nXpE4scQCqrpu9kreBixwe/JLlMKxMI
	vrT85eCm75emMwJi3lk6vG917mgj55VZH6dMykbg+CswSf7znIBLIlA/+6gT1XMerX+HldHlj/3
	fm3a/+vYoP4HLTFbcdn7KLQFMuW0SonceDRVCzAFvta+2Ju+w9X/T6jl3DIgb+yUvrCHhdgEJf5
	P4/TrRpQQJfLqwbGyttz/D1NZK/g3GKpYlrnx6HFlR/ZdMWVQ50+aBFPpj/Q30ufUCtXKRxtBEX
	dyUvuWRSXvZv8PGUXcHDEjBTyP4couCdt2Z1m95+iltOz/otbwk37tyQdNXPjWOkjWtnnnP30jD
	aHO5a2UYgknNFoIA8N1dFH42U5+gXzDxpf7yuk7a76gokMFEYQ0kcSWkcdnlF4nkd4BdrIh48xl
	fC4eZ8w5FpHGLpGKTDarY9bA99Cfp8jKHlBanx/HhNmo9v6TXgoPOfnBBin5h6lBIHRtMDoYv6V
	82ifddcg3kBlDk=
X-Received: by 2002:a17:90b:5844:b0:398:e436:370 with SMTP id 98e67ed59e1d1-39b260ff0e9mr32411991a91.2.1788748045768;
        Sun, 06 Sep 2026 19:27:25 -0700 (PDT)
Received: from [192.168.2.166] (104.194.78.75.16clouds.com. [104.194.78.75])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b07b197a9sm23626169a91.0.2026.09.06.19.27.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Sep 2026 19:27:25 -0700 (PDT)
Message-ID: <33037304-19c4-4d28-a550-b0b45a560f55@gmail.com>
Date: Mon, 7 Sep 2026 10:27:18 +0800
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 0/7] docs/zh_CN: update DAMON documentation translation
To: Doehyun Baek <doehyunbaek@gmail.com>, Alex Shi <alexs@kernel.org>,
 Yanteng Si <si.yanteng@linux.dev>
Cc: Dongliang Mu <dzm91@hust.edu.cn>, SJ Park <sj@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 damon@lists.linux.dev, linux-mm@kvack.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260818070358.455768-1-doehyunbaek@gmail.com>
From: Alex Shi <seakeel@gmail.com>
Content-Language: en-US
In-Reply-To: <20260818070358.455768-1-doehyunbaek@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Applied, thanks!

On 2026/8/18 15:03, Doehyun Baek wrote:
> Bring the Chinese DAMON documentation translations up to date.  Update the
> DAMON design and administration-guide translations, and add the DAMON_STAT
> usage translation.
> 
> Changes from v7:
> - Use the suggested translations for the DAMOS quota goal ``nid`` and
>    ``path`` descriptions.
> - Replace the remaining "聚合间隔" with the consistent term
>    "聚集间隔".
> 
> Changes from v6:
> - Clarify the DAMOS quota goal ``nid`` and ``path`` parameter descriptions.
> - Improve the translation of "offload" and fix the duplicated character in
>    the non-access-pattern filter description.
> - Consistently translate "tracepoint" as "跟踪点" throughout the series.
> - Consistently use "监测上下文" and "聚集间隔" for DAMON terms.
> 
> The changes were suggested and clarified by Dongliang Mu.
> 
> Doehyun Baek (7):
>    docs/zh_CN: update DAMON design translation
>    docs/zh_CN: add DAMON_STAT usage translation
>    docs/zh_CN: update DAMON index translation
>    docs/zh_CN: update DAMON start translation
>    docs/zh_CN: update DAMON usage translation
>    docs/zh_CN: update DAMON reclaim translation
>    docs/zh_CN: update DAMON LRU sort translation
> 
>   .../zh_CN/admin-guide/mm/damon/index.rst      |  15 +-
>   .../zh_CN/admin-guide/mm/damon/lru_sort.rst   |  68 +-
>   .../zh_CN/admin-guide/mm/damon/reclaim.rst    |  82 ++-
>   .../zh_CN/admin-guide/mm/damon/start.rst      |  63 +-
>   .../zh_CN/admin-guide/mm/damon/stat.rst       |  94 +++
>   .../zh_CN/admin-guide/mm/damon/usage.rst      | 523 +++++++++++---
>   .../translations/zh_CN/mm/damon/design.rst    | 667 +++++++++++++++++-
>   7 files changed, 1345 insertions(+), 167 deletions(-)
>   create mode 100644 Documentation/translations/zh_CN/admin-guide/mm/damon/stat.rst
> 
> 
> base-commit: db6ed2a3d31068ca5577466591b2521dee0508ca
> -- 2.43.0
> 

