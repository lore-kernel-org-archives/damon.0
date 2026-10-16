Received: from mail-pj2-f3.google.com (mail-pj2-f3.google.com [74.125.227.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C9E3481ABB
	for <damon@lists.linux.dev>; Fri, 16 Oct 2026 10:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792146899; cv=none; b=EYiwI469/2xjYsg8pJeCsIvwn8WqQ3vfn9u80W7OG2dkRu7dNtG1Ey2np0QuksA982XxZPHy6ZjAazn0vE+jWGWdwtttiHIP9G8/FMzBqsTIrZ08EfrslXgPBtP7o+mlme6EsWRfbChy+20hC2p+Uk1GQqkFPv7J7RlMKbfnk64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792146899; c=relaxed/simple;
	bh=1UJk2cXtDpU5Tf17byKlHtWDaHy883nGoAa8Twsmlx4=;
	h=From:To:Cc:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Date:Message-ID; b=uV1qUr1NAYoAQ7Hb10VnqSUIudm7mM1epO9aS8Ent5aHY1anuzy7tPY03jxcn+IH2/HT/fUH892zwLeRttUC/hxo/nDYfRpBk84U15H9LdlQnwZGzDLdxr26g4KeUEx1x4JDGpYgB8+PAO3JWHGkQiCZLDnaVZ2KniRXyq+CCmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y+iR08ln; arc=none smtp.client-ip=74.125.227.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y+iR08ln"
Received: by mail-pj2-f3.google.com with SMTP id d9443c01a7336-2e831901331so38111175ad.1
        for <damon@lists.linux.dev>; Fri, 16 Oct 2026 03:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792146895; x=1792751695; darn=lists.linux.dev;
        h=message-id:date:content-transfer-encoding:content-type:mime-version
         :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1UJk2cXtDpU5Tf17byKlHtWDaHy883nGoAa8Twsmlx4=;
        b=Y+iR08lnRzqDCdmXQZ1CmuJNCVqonUvkI28jYxASI3DQAoc0jq06gD0Gys8k/lSsR1
         m9Modomj/a4R0ec80lKw4GQqBQjyRlHkh7zsroYGIFmbOa+Z8W/VIDLKV46nkflwAmtJ
         bgRj/DcplptBlsf814XpP20v+um96x1YpXCSUULjbytg09YV5LUhUVLnDs8sN8X8Am6K
         302I98ERxGiEYv26W/caK198g6vaPimEagQV4jjR3gv2AfOHm97f6Vg9MwonCsaDG+sP
         xc2KLnsLua7//LW97Z/I0XarF/wu9NF/VQpp1vwMaIB55BAyf0apSXpGg77TagYhiXQ9
         PglQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792146895; x=1792751695;
        h=message-id:date:content-transfer-encoding:content-type:mime-version
         :references:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1UJk2cXtDpU5Tf17byKlHtWDaHy883nGoAa8Twsmlx4=;
        b=BiBLiRyJ5YUZQ3/R4qMVh4wv98f/sG6zUaJQd12z6fliIIlkW6+7cxMTMcB2uDZy1k
         nvj2mUGw1MGVKvxlCOjpWA3j34wompGfQB1zBIdhjZi/9vg8DkvJPehsfCKRMy7jeVEa
         AKPdiUTuSt2z/KEn/+T4C9vtIzrNhX4C5nX8RYZPOBeIlIbsOLmqZVbWhH06HLuT8AZa
         +nLTaiIhwnaL1z7W7KbF4bQ9k+BgNDr/YziyKHWAE6jId9CFwaafnZa8TAWYmB2XVhS2
         /WstpMlVwo/dHK7ktF+WB7XUtXSlIFmc02mhwNmWCNwhsUQrKsX3xvbjn2j84V650L6Q
         QMJg==
X-Forwarded-Encrypted: i=1; AKwUvBywYiOGT00X0PcX6KEiXLE9mWqBs437aIwhobbTtyhfsl2CwV7w5YKixIR2Y1/kvSRO/1zvkw==@lists.linux.dev
X-Gm-Message-State: AFq9FYKgXPJkwwNJq5fUeTGReN0883LOJdrtcEG2VV6NEP8W+hrcSpT6
	4Iz+84pIjHUf6oWeU3hf0jCXtbCsOGPU2yPR2YonHFitXC4S98DhMK/x
X-Gm-Gg: AYBFou0djthudsJJS81mNJmmQsMs/Gq5QQJrzu/AAcwi0ExA8K0aiaLtiGbbW+SH+Kx
	+ko+2qJJ4FZT1mpE2CcBvHiQ+WqV+8lz5MaHqmiElaw/ocZYlWYoFvKBuajAsqeptKyoFsMK5ra
	fXI4gKSfj7b/0L/F3r+iH8mO7JBkVnPgZbMIAV1IWvFrjdGJ3OHpNQV3imtoAl+SJEANYT9W+QP
	nKLmgraQtrGMV/Qizje1NTgBq4T1V9Gup928VnHKgM5573BwS3Uu8bkkLDmg9caaTVTjg3lc51s
	S/4S0rlr3StW9+KOYgQPnt9JwTPb36OsG4b+dDpyX2CPOTfISHqimio62VCCgeR21/JpEYab8cK
	tHC0cWG0HzSho89tGZt0GgIUOaCPLL/LQ+Zt3aS1uEtQqbFB6NyGchYozAcT/klkbC/1brwu+p9
	37EzuEGSJzXogV90pcvQLaKpj+g1GogVYiy7wc6cIOrZfTX1WOgqWJ9z91+cwDg6JCmLxqt1l6J
	ogpeN9M7Q9lsfVHrbPzpjMFopezDBIM
X-Received: by 2002:a17:902:f601:b0:2e9:5772:9ab2 with SMTP id d9443c01a7336-2e95772a81fmr57548795ad.41.1792146895099;
        Fri, 16 Oct 2026 03:34:55 -0700 (PDT)
Received: from [172.20.10.4] ([183.137.20.64])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e97e87891bsm8239915ad.48.2026.10.16.03.34.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 03:34:54 -0700 (PDT)
From: Aveline Noir <jm5905938@gmail.com>
To: SJ Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, damon@lists.linux.dev,
    linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/damon/stat: avoid 32-bit overflow in idle percentiles
In-Reply-To: <20261016002130.113813-1-sj@kernel.org>
References: <179207592479.3.11595453180868898703@gmail.com>
 <20261016002130.113813-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Date: Fri, 16 Oct 2026 17:22:58 +0800
Message-ID: <179214257862.2.17756454862637555633@gmail.com>

Hi SJ,

On Thu, Oct 15, 2026 at 05:21:29PM -0700, SJ Park wrote:
> This patch is sent as a followup of your previous bug report, right?
> Unless it is very urgent, please make sure the previous discussion is
> completed before making a followup action like sending this patch. As a
> rule of thumb for DAMON, I'd suggest waiting for ~10 hours after the last
> comment on the thread.

The patch was already prepared and additional tests were underway when
your reply to the bug report arrived, so I went ahead and sent it.
I'll leave more time for discussion before sending follow-up patches.

> What is 38?

38 individual VM runs, forming 19 before/after pairs. The 20 same-image
runs formed 10 control pairs.

> Do you have a plan to run more tests to be able to tell that?

I've run longer VM tests, but even same-kernel runs vary substantially,
so the overall patch effect remains unclear. In a fixed-input 32-bit
userspace test with 10 regions over 256 MiB, the median increase was
227 ns/call (+42%). The old code updated 15 entries, versus 101 with the
fix. I haven't separated the extra updates from arithmetic cost.
Maybe we could record region counts and sizes alongside VM timings to
check whether both versions are doing comparable work.

> Any reason to use div64_ul() instead of div_u64()?

total_sz is unsigned long. div_u64() would truncate its divisor on 64-bit
systems if it exceeds U32_MAX. div64_ul() preserves that width and maps
to div_u64() on 32-bit.

Thanks,
Aveline Noir
