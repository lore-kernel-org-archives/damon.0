Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51771376BD7
	for <damon@lists.linux.dev>; Thu,  3 Sep 2026 08:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788425159; cv=none; b=rWfcAzmqPoqOiCcPvPgu/59Shfup0ol0NlSJQDDuaE7dqEYdF1C1NVioEpttW1YbJYuv04EfKnoXg05ezyqR/GEZOpWDQd5tbeg+yEoIkT492ZWG9IV8yXJFJn2giMyivxPMqappgO6KCTudM3yLwxo5GKlzdop26v3VC2QQgQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788425159; c=relaxed/simple;
	bh=tpyUzXZw87JQOB2A0BtVRjrqgVQvcnGOu2KYNihB4wE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U/tbXwyc77ytG0xY581r+J3kgrTR0iDwcZ+YliYNFeZ8GzC5uLF5ar39XnaRgKzIlr4hIgoeDBtxKjHLkXp/fPBLm6dFOk23+J+JzTt+SZ+Ilzfb2u5RsOe2xAl5Dsbb00+pkC5M1ixFWb/Xvbd3webwIwtmew7mqSeEgJXm0+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QEIJxAsB; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QEIJxAsB"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-854f8068301so1241225b3a.0
        for <damon@lists.linux.dev>; Thu, 03 Sep 2026 01:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788425155; x=1789029955; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RIa1KcxtKlzePvmdnnhCHyjrKBpT+nlLmPKgX7ZVzsY=;
        b=QEIJxAsB5gck0IytyRzKcEuoPxQPQR9NHwQ8XwVMLx4bQADxYvPVKSyhB0lMtW1pg7
         tv/sqT922W/sGpgJ4ZAiG6xNsbd7pXWh4WIA3A30h4P9z2uUxkmvqLkmpwOZJ1JXeCSs
         uywpEFzlrk8cGZycHrZEnX68b/HtKMm9li9NoEv4k/pMqDhVgn2KMErouPPmgieftI+U
         Y2lZpwQ7mRbEVa4OrpJnafDr70U55A22LqoK12TjF9JOSujgGaHOFpIKLj4ZTkBIK8Vt
         ShpZEqlBEoPjau7df6rWyzRbR5l2UukPeDCJgpiTTWWo61Si91ZWPcYvtg6K4LVwINM5
         UPSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788425155; x=1789029955;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RIa1KcxtKlzePvmdnnhCHyjrKBpT+nlLmPKgX7ZVzsY=;
        b=E61Ey8jr8CRh4qfo0XSoHzc/cwGzM1mAjrDkYVN0EHbl91YODDjCBE0G7aX4C6G0qJ
         PNLI7AYvZZRBEeTeiErb1Xeh0UpmtiiYtmSSGyoT8fjQ2P+znOZc93+5iA/oBT9d1Znw
         7JhdmsdMkZG70tapXAsmJCmBP9Cz1Lqi0TbBtkFs91A3prFIcXroQ3i0dgVHqQYsOoDZ
         7LBfxog9FiSRGaIE72DDQT3vus1OmTfDdK+xC0zAshAZfxz7XKmoiT5PC8RGYY5Cn/He
         okpoiQeA/3CL7ho4IXcugMmdaDSB7KiFhjxBFRHLOR0WFpSkQOO8OF7/e8uqlRMDlGjh
         tl+g==
X-Forwarded-Encrypted: i=1; AKwUvBwqPoOmaa4az9jFt8uJ3blrFO8t6hXCxHguW52A/uI+LrkP7rh70a1M/WEXvgfmV2/2OTbKUw==@lists.linux.dev
X-Gm-Message-State: AFuF++mErbIGzJryj9pf1NKvI17d/N98eegqPPjXZlsa3o9wjb1klU8s
	7ACZ3NZ5YVW5KKaI3ugenbQsFxsQKV36e7w1WsZrZnnpAS7WYujJ4gwcLaE938rt4Fg=
X-Gm-Gg: AYBFou3niA5IxsKYf/frbA52ZwoV8piI9GK4HoECczAPA7tx3ytPrw1FVh1lB57YUqX
	1LzrkBFHXej8sqkJXElRlK0PPZyoYkP2DTF/ivhqt6ecJjypGY/4isn4UrhSMDGVYqYobxYgaMS
	d5K8wreGWPUWseZRQOiT8s8NrkJZujylIgWYjDqeieeTQ+SXcnpWJiE6cCD83DYYC8rIEFjKtDn
	7ZqV+me+AY0gkK3iyelVtMQOF7rW+4ypRfwaK7rMci9nluKpK+eGufRV7eo+7a1vk+bJoZmj4mL
	ls3jh0aBZryL3+EPogkJq+bDgu4bJFngQNJmbAurE1EXmVGwn7ELboqWqV20mmeZd9zqVSyzUbL
	ocsYzj0+8dCoiV8+c1JPA6CTNfyY2n9OxLeWTiDrFCC7dpbvJzYTYkFPdNDs8MirS1MT2lH4S/a
	Z4kWvwZfVm9ClX6QJvQfaK9Ebjn97Zqr3ZoCn4Il5Zkz2qhtH0pl/XmCPlabQ=
X-Received: by 2002:a05:6a00:3696:b0:845:e8b5:8c49 with SMTP id d2e1a72fcca58-85ed24e33ebmr16410228b3a.10.1788425154963;
        Thu, 03 Sep 2026 01:45:54 -0700 (PDT)
Received: from gmail.com ([185.220.238.35])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-85db24f2e82sm2494935b3a.3.2026.09.03.01.45.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 01:45:54 -0700 (PDT)
From: Kunwu Chan <kunwu.chan@gmail.com>
X-Google-Original-From: Kunwu Chan <kunwu.chan@linux.dev>
To: SJ Park <sj@kernel.org>
Cc: Kunwu Chan <kunwu.chan@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	stable@vger.kernel.org,
	Ravi Jonnalagadda <ravis.opensrc@gmail.com>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Kunwu Chan <kunwu.chan@gmail.com>
Subject: Re: [PATCH 3/4] mm/damon/core: copy nid for eligible_mem_bp damos quota goal commit
Date: Thu,  3 Sep 2026 16:45:45 +0800
Message-ID: <20260903084547.960584-1-kunwu.chan@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260902002725.108635-4-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue,  1 Sep 2026 17:27:22 -0700 SJ Park <sj@kernel.org> wrote:

> damos_commit_quota_goal_union() is not updating the ->nid union field
> when the goal metric is DAMOS_QUITA_NODE_ELIGIBLE_MEM_BP.  Hence, if a
> DAMOS quota goal of the type is online committed in a way that it will
> reuse other quota goal's memory space, the new goal will work with a
> garbage nid value.  As a result, the DAMOS scheme can show unexpected
> aggressiveness.  Do the update.
> 
> The user impact is not catastrophic.  No leak or crash happens.  Doing
> the quota goal online commit that can reproduce the issue is expected to
> be not common.  This issue was not found by real users but the AI
> review.  That said, the issue can reliably be reproduced.
> 
> This issue was discovered [1] by Sashiko.
> 
> [1] https://lore.kkernel.org/20260827045035.94611-1-sj@kernel.org

Hi SJ,

The fix is consistent with the other node-based quota metrics. I also 
checked that damos_get_node_eligible_mem_bp() directly uses goal->nid 
when calculating the current value.

One minor typo: the [1] has an extra k (kkernel should be kernel).

Reviewed-by: Kunwu Chan <kunwu.chan@gmail.com>

Thanks,
Kunwu

> 
> Fixes: 9138e27a3bc3 ("mm/damon: add node_eligible_mem_bp goal metric")
> Cc: <stable@vger.kernel.org> # 7.2.x
> Signed-off-by: SJ Park <sj@kernel.org>
> ---
>  mm/damon/core.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 20748b0a71026..53c3f97e3f126 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -1143,6 +1143,9 @@ static void damos_commit_quota_goal_union(
>  		dst->nid = src->nid;
>  		dst->memcg_id = src->memcg_id;
>  		break;
> +	case DAMOS_QUOTA_NODE_ELIGIBLE_MEM_BP:
> +		dst->nid = src->nid;
> +		break;
>  	default:
>  		break;
>  	}
> -- 
> 2.47.3
> 

Sent using hkml (https://github.com/sjp38/hackermail)
