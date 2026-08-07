Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98DE235B64C
	for <damon@lists.linux.dev>; Fri,  7 Aug 2026 16:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786119515; cv=none; b=jNF73JBvtoztCAMbyfCBmWXwwlJCWZL0R/3BL6mmEXp1YjC1t9pMtkh3vZ9+1mIJMob445/sJgOelFeimpp0hd1CcMuOH7WZw8T5Mt0e+7G7OndE9YVMlyZHbRfnbyqi8RFkQWjsLy9zNIbxjsTxStPSueMON9fO4hO2AC2h0vM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786119515; c=relaxed/simple;
	bh=tlp3VXeCrrXRAjB46dFqAB+KccorwO0H845kQ/Ql5Xo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LiBSJIjRrpDrP8b6h2ac5l8vIEcJRKRCs7z6gpcb3WQNGiIRNCqANP5mghQI7YDcGP8CM1E7sOd947v5ogmm5RuZvcRmEwRXXLuQ//AIabHYOpRHNAP6clAikfuD9QCL0qWxB3/6mGfns9mvVMVW7ZBUnbXX1KZHFndCez7PLO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GzzFOm8x; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GzzFOm8x"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-84862b0d5f8so3316607b3a.3
        for <damon@lists.linux.dev>; Fri, 07 Aug 2026 09:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786119513; x=1786724313; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=15034nKXWgrfjc3mE03PSssA+Qfib9RRfUt9G57sL/M=;
        b=GzzFOm8xKCMSWpYioqRKqFehShNQ1oyFb4C8SvEl0k3NDSKuznh3vd7g/TzlBhIEpC
         uZPaNPSmgKumJ20B60xIukBMeROZg0Q4qmLwU7rhHX4GsmlWyzkKJ8aseeBcRhC+3qpW
         UK+RUenMXOu64yYpxWqM5zkDP9fKpNdwTZdF2jV44Pb+59qu3e6lGoybUruvr2F55gjY
         CykNbviVm5WbOV+FEIgs/TqW5OaKTAZt3Q/wwPnAw2sCFM6pFRPclLqt76kcwkRtFbdc
         EDU/HDZ5Ly4l7bpNaNXZMsR1uvQFN9QSftKCkHjjMOg0ReDATZLL7zu1BaUPQAB0rmfd
         vrgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786119513; x=1786724313;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=15034nKXWgrfjc3mE03PSssA+Qfib9RRfUt9G57sL/M=;
        b=oWs1wOrL06RExHetgtKN9E/n+iZmkUTM8tVTgM6in1USzBZvnXfYabyaFZa1EJaeWL
         mrnehZ8BSI05NCfCTAriiIcK+I26s0yb/PdZkFLzosMwOBkgdXzzE76w7HUXH8aOqm3/
         Me6BrDCGPO3yxrdRVfh3UMpELfKSeOxP+Pu//sEcpbGiUAHmN9cLWBCdpLhXT2B1fUcN
         YgPo93AYqL/qruTzxHgSf3kpFVqcUBj0BvF+HPZOfVwygeViRU7t0BrUgqTPi95VqVNe
         0fbbQxwSuRe2DCCEGPhE8IokHDHvYwdfpA+qkh5sWnPs3oW0rKeZfeYDwRzklHtgGh1O
         8tfg==
X-Forwarded-Encrypted: i=1; AHgh+Rqe5ARB8kLyoX9YQS+kRLE07wOjGyJCqzz7aAv4jEc9/hXZQzlwdfsKpEI2FSta2lyfJBlZlQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwURf3PLrCPDPnM5vuVoYRhmohtxoKgZSPB93CPRiCgTbtRwB4g
	CCxdZnHIYOm+JrIE4JJLtvOkruNwsq4VNxzb8FnBFoAM+Iy80iMhckvaVn47Rg==
X-Gm-Gg: AR+sD12jkX73xDuUUHGeBDiHTiXcY0cNvPAPJyXRUSksSucaaW5bHvT4InE/NZoLfRl
	v+XVGHJS8qErNdpKxkk6XrWNX5p4/sQRnI6gQiMk1VPCV1c+r09oW+XWkutElubfG8pgYEPCMJN
	tp0hVXnErzn1BmOeiQZx2665OSNprs+aEJN3iikilrq1lJTlBpcCd77vKd/oKePMQT15jQExltx
	f4fmCytQFKGk30Vcu2wmf641cWW4pKsShHjsRqxu44YigeUsxBA83SkzaNdz4okzhhEa8mTacBD
	WkVObNRs03tx4SLAtvP2o2Q9vC3NvJgFT/KVJloLrhXbCl+ZqMZJ8jafQwiWEhnDsAxsttlTG/1
	PgzRNFmP2JqK21P6E0F64qtxVzNe2obPakIw8fmUN6WDUtHCb8FAflMuekRtZiqDVFvIlY97+vu
	q9zTUT8vRY2qXFRkv7xcj+eCWQe2JaDw1OB0zmWUUvJxMlEGdCSJreU/qvSwz4jxCV4JPPaJR+E
	KMkSCa7S9xe/atI
X-Received: by 2002:a05:6a00:399f:b0:848:42a7:1854 with SMTP id d2e1a72fcca58-84f4fee21bemr11529881b3a.39.1786119512747;
        Fri, 07 Aug 2026 09:18:32 -0700 (PDT)
Received: from celestia.taila51cc2.ts.net ([2402:1980:935:f4a7:6f5c:e816:9aba:2090])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84f5a3d1155sm1318232b3a.20.2026.08.07.09.18.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 09:18:32 -0700 (PDT)
From: Liew Rui Yan <aethernet65535@gmail.com>
To: sj@kernel.org
Cc: aethernet65535@gmail.com,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [PATCH 2/2] mm/damon: skip deactivated schemes in watermark checks and add fallback sleep
Date: Sat,  8 Aug 2026 00:18:40 +0800
Message-ID: <20260807161840.56993-1-aethernet65535@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260807140739.91238-1-sj@kernel.org>
References: <20260807140739.91238-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi SJ,

On Fri,  7 Aug 2026 07:07:39 -0700 SJ Park <sj@kernel.org> wrote:

> This is an intended implementation.
> 
> When all schemes are deactivated by watermarks, DAMON stops monitoring.  It was
> implemented in the way because we didn't want DAMON consumes system resource in
> the case.  But, later it turned out DAMON's resource consumption is really
> negligible.  Rather, it is turned out that it makes DAMON runs with stale
> history when it is activated again.  Particularly, regions have 'age' and their
> start/end addresses that was emerged before the deactivation.  Those are
> meaningless and could even cause wrong DAMOS decisions.
> 
> We don't want that anymore.  For a case the user really want DAMON completely
> stops, we introduced 'pause'.  For max_nr_snapshot-based deactivation, we don't
> intend to completely stop DAMON.
> 
> Maybe the documentation can be updated to further clarify this.

Thank you for your detailed explanation! I also glad to hear that
DAMON's monitoring's resource consumption is negligible, since I plan to
add a contexts/<N>/always_monitoring parameter later on, allowing users
to decide for themselves whether to keep monitoring even all schemes is
deactivated by watermarks.

Best regards,
Rui Yan
