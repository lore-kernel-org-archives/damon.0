Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F31B644A407
	for <damon@lists.linux.dev>; Wed,  7 Oct 2026 11:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791374022; cv=pass; b=GKK/tI5xboAA9kjXvVDGGuS/fcfLiYWwP8tA9fMSeZeG4L3IyY++OXNkf+cRwsdizpQ97CA4K75blwB5RyBZlo1qYMljUVslZ3AJ1kdgrO3diJk5ZwEWjvrBTKmLnKYsGXdskhlWNV8+wNFsLqQMXMgyQqb54jj3Fig/IcmchnM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791374022; c=relaxed/simple;
	bh=l11SxpTuwANf57f5KsVOqnNNhjMstDSs7fMcPi3T/OI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CYYymJRPTVjodcrugt/wDNUXfrkMUZb63FyKU6tSUTsQN/L43A8lQYgzpaKif+1iDi+KvocbezWNNm/qAc2JE+KUu6Pyfpl+MfSkdGMDMq9bj5GiQerHevwMsttTpiY8BfcVpM/bbXNyIJzadoEWvBh3PggL6dFKTj8nvRcrke8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MuMMeTZw; arc=pass smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MuMMeTZw"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2e5378b281aso9899955ad.2
        for <damon@lists.linux.dev>; Wed, 07 Oct 2026 04:53:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791374012; cv=none;
        d=google.com; s=arc-20260327;
        b=U1Yd9yUm+GvKjUlfdu4OCahq8MNQtAX5vtvqGdCNcQlXwVAluBuaIb8ZOTWEVISoCQ
         FwogjiRVOcBFq+2YUOxt0OxrZ+RLFfEGjkzBDoQ16z7J/kYie7LuR/X89x8nAGMFLAoB
         5qzNum3XXufvlaofa+SB7HpFgEVQSKp+8071sqmr9E51OueHouVPHYyisrVaN0GvqBEb
         raIjWJsJW2ngMndc5bCwpFkusXF976MIc1EZLfN1wFIi15aM4vLsQbTYo0PEuBKPPWX+
         6MM1gftlLSZwzBvro+ixSRiDdf8BOj4Rt1qu001T130QLZX0cevUGnrXn9GiA/zcYlQj
         H+nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=l11SxpTuwANf57f5KsVOqnNNhjMstDSs7fMcPi3T/OI=;
        fh=CLkZQJ44OV7/aCUuyaGelIkCehpEeK0GyY9lDN0Xk38=;
        b=QuPyz4WM/5PJOikpVO2LPtiJLiZqY/xlI5ZVidnurw6gl9fFuQmmLsHm+KbAI4BXbV
         lfyVQOSz3ZEUB/GKotEAylc4uw8p6buUK/U32/lACRQ7a5KbI0lHxGBJ+WMp3942eN4I
         H6W5mG2jAE69gUQlCVfq05wjyj5CI6AQEh5H5/uCkw4B9r8PEw+nEakg5CGEd1D3PUIz
         QHX8KrtKwvSK/LQWG/0+QhJB+DBuleLmnz3R/QYNG3cm6N+vjMe2DTUCKXEmg7T99iHd
         EWQlWyvBCxVVpljq386xThUL9XoQLNpY0pg+N7raNJqxZGNElb/L9fdOXejXMsRAxP8p
         OnQw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791374012; x=1791978812; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=l11SxpTuwANf57f5KsVOqnNNhjMstDSs7fMcPi3T/OI=;
        b=MuMMeTZwTb1QG9NtPF6jNfBxoBK3WxFI13mbGG2wdKz/MOcuasbDp2OapG14oZyB2g
         4dxEtNDwiijSn5k5t8Q18rjpNq5aaPObXw2nJI3fN20f4xNKetGjT5wDe2euqqNKYfr9
         dWF6rIFWNunCQMBn+vmXiwyiD8lIxnQyPA+/R3wR6TTU1DT1XWL0YKb6Kc0vtgSlDZY6
         LdRHb8yGh3i4T+aLO2j7OA+T0woTGsfzW6Q+NJp9wkThe7KDtK4NVkqM0b1MxO2QgkZK
         y7Ex3EhFFCnp7ADehSE4DhCaQfqUhgTqTpm7l0ISvwCd2/jBZiEa0XkdhvvE2fcOdowp
         Aw1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791374012; x=1791978812;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=l11SxpTuwANf57f5KsVOqnNNhjMstDSs7fMcPi3T/OI=;
        b=PNG+sT7GHgIFeVduVasPn//FijsocccrJhLh2vxMu1GrC6llBsccuFM3VEaJWvzIoz
         Lx+u9HmgDcPV8606Rx4dVgV8pYMtJyXC/7q26EcMHnPFa00Y2fSQFhR6tdUG7GNwMcJG
         G9ss0T1ynpP64XvkhKK+0RRZ3krOsM+lGKtBlvYjIT+mZDOmYTX72hFfOw+jeUG7/ADg
         U3jEPxHzSA7Wid3BkQfOUMCzeaPSXYlC8SpY8Uw/C3obIhP7t4dbXd9vvT3thPxzBW7W
         2imka4n8PibNadGY23HFTnws/Cnlil7vDpOWPF3aeZcqF42VHM9vbAlAJ9OlCQS97uyP
         59cw==
X-Forwarded-Encrypted: i=1; AKwUvBwuGRzWHxDTFcorpZ57mcmRxv1+sX+FuTiKn2qtyQ8eIQNsq43Boe7qPsjLm9j8qnbCM0m8NA==@lists.linux.dev
X-Gm-Message-State: AFq9FYJ9wRAR9ppi+hv7UyJIeZoEU8iS3i5QKTJ80T+ty9pAlD7jg8F0
	B0UZ24MPmc5AMqflabOwoNnk5hSDQ0eEhOT9x9GuxGXGlFglFHKbZgmLmeBaQACeEPn6luvY0/f
	jcrf5b7DOR4/dUEvxdofnuQBak3DjLw8=
X-Gm-Gg: AYBFou3dtG3XQ7qgBLIr7/ENNmyq/wbi0EK1hy9JnstzNcJipTYzdqfE0esz7BBZZ4/
	wyPAHw+WuNyTNUz6TyRrVxKRKmDW/MJf98a/vED1qlp0Mw+o5vqBegUGg82xMq/ykyfdoj5pAfP
	eKjSbEodDCwKK+HefDV4+nGzYjSVBAC8LR43UTVIcSRxV7QykMxZLqfcOU18pPtD2IJK4nLnRO7
	x2b08kbNrF5nqB0ymsZl+OixO53asxYE2Dv0NomIFkt9OHfuxXIkrnIpB8PJFziildJ08njhwqg
	zkutALYzN7le2rVJFpzMVS8sNHBoff+hLSP2TVJZKa9uZK1Wvdx8MImiBX4G6U+voZLl5r5wTBb
	+q5KhJNMi
X-Received: by 2002:a17:903:110f:b0:2e5:c563:c0dc with SMTP id
 d9443c01a7336-2e600509c23mr20094385ad.42.1791374012035; Wed, 07 Oct 2026
 04:53:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20261006061549.627-1-adrianhuang0701@gmail.com>
 <20261006061549.627-2-adrianhuang0701@gmail.com> <311d97da9ba4b870ef03aa412586b751bc7da3f5.camel@mailbox.org>
In-Reply-To: <311d97da9ba4b870ef03aa412586b751bc7da3f5.camel@mailbox.org>
From: Huang Adrian <adrianhuang0701@gmail.com>
Date: Wed, 7 Oct 2026 19:53:18 +0800
X-Gm-Features: AclHuK_APIuynXW_Vvb6ZGIqmtWSwMFkf9exrzESzLpquCiFRKPp55oN2AWzJJY
Message-ID: <CAHKZfL3z0-fVa7HhW+J5E0RdEUoR-E3wMFYmQ6C0ZQh7t1xoGQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] Docs/admin-guide/mm/damon: Fix various typos
To: Manuel Ebner <manuelebnerli@mailbox.org>
Cc: SJ Park <sj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, damon@lists.linux.dev, 
	linux-mm@kvack.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Randy Dunlap <rdunlap@infradead.org>, ahuang12@lenovo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Manuel,

On Wed, Oct 7, 2026 at 6:30=E2=80=AFPM Manuel Ebner <manuelebnerli@mailbox.=
org> wrote:
>
> Hi Adrian,
>
> I have read your patch and the affected files. I have found
> a lot of issues, non in your patch.
>
> This got kinda big, so if you don't want add it to your series
> let me know, then I'll make a patch on top of yours.

Since you found those typos and grammatical errors, I think you=E2=80=99re =
the
best person to submit another patch. The credit should go to you. ;-).

Also, as SJ suggested in the previous email, please post another patch
to fix those issues.

Thanks.
-- Adrian
