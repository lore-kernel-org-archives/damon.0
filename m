Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.135
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793069276;
	b=47hyyQDx3OqdVx4QTJgovSrvMJ5+vbd7fW8dw6CBDtDzQJHAmwxSTQClC18k4EdkG9ri
	 sH7Pz0c1gp/07bn0Q3DbBbgSElxS2ArQrRxVTTkc5g7FVAFJFJdyXh17q67i97iJ4Fm45
	 SvNmIMS1+eWwJYRKZgkmHeheP8vEevg4RqnJZrr4h2Feuq4B10oVhWMS/VulhPVY4i0ND
	 BoHvu/AT3IAuKMOd4MtmuWdmJKqghxbQyJcpkrYxNRO0XiUzd0PWNM6hRt8pFQHafslnH
	 UqS71xH2uSozYAfvfr/IWFDfYVJS5WViSDTMIRhVSu7qkTYwUNtnenMZyF7mjfaam6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793069276;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:Date:Message-ID;
	bh=lvDhK1lQBCnTBgCeDn8IE0UD8FXFRVaT+2qmolhhuoo=;
	b=BvgiMjf7xCTGZ2HHVmrR4DSlZfOtK0CGN0tlQ8oKS5J9XVoIEitfMxGZz0qYOy25Qrd0
	 WwvN6HkbJTQCMUTUuwwJ3+ICVMqUQHo/yKt/N1Z8BCb6OTVfNmPKjSFxYzb3D22vnhrNT
	 zQh78CIA8YYqHun83wGj4aoVRWaRlSDPfArfDwM/bD1W0g0UUQc3GruX18CunPBE2leX8
	 DN1hEwAfFYCDutaRLQvAoLBnhItZvHD7fWoNBah7F7RfGkcjgmHHHTDrfGkGOo6Lp4muO
	 HXc78oDQSlgRn17hqDfUPYan/THHHOVYwuuGBf8XHa2iuKCxGQQX7QysjmAvPZNfozw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=74.125.227.135
Received: from mail-pj2-f7.google.com (mail-pj2-f7.google.com [74.125.227.135])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F76A606A321
	for <damon@lists.linux.dev>; Tue, 27 Oct 2026 02:47:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4F76A606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj2-f7.google.com with SMTP id 98e67ed59e1d1-3ac63aee1ecso707936a91.0
        for <damon@lists.linux.dev>; Mon, 26 Oct 2026 19:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793069266; x=1793674066; darn=lists.linux.dev;
        h=message-id:date:mime-version:content-transfer-encoding:content-type
         :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lvDhK1lQBCnTBgCeDn8IE0UD8FXFRVaT+2qmolhhuoo=;
        b=Avv8dYPROLORNH94EMdZg/79ANclns3CV1GBlZiSC/aRlRsguDFoUc0mG/gu6zBM0Z
         Fpl+FI0lK1fydTYYXKXfeWs2K2Pr+p1lNhdIfAGCJCI9Nt+GeUYzMmSwxcq2u/TaIS4H
         UFt249Fky0tKTIgKOZCroVicCmVgyVoFy6LiYyDOsEje83iCCy4D13rwWZtDa2XjHJGT
         I0KJMziri/IPE8b45++Kag3uTW+KPrk9g6u7dvol5IN4wSbnswm3GzbaRF7+JrSWGF6g
         uzP0f0Jg3Na2vxUCf4PZnrADIs9SR6zrIgTgMTNnirboKQVqMZA7IOUvvffatawa2l5F
         dBmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793069266; x=1793674066;
        h=message-id:date:mime-version:content-transfer-encoding:content-type
         :references:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lvDhK1lQBCnTBgCeDn8IE0UD8FXFRVaT+2qmolhhuoo=;
        b=uTS7iEvsLaVpHRFkoTpCHdaYtcUGFvZI+iN10JiUcxDy1tuqHPakLdctivVEF0EhYB
         miGW1zeHWxamAf+YOZcGhk982Q/9ZKVe0kZxquNTvAGMbfu+2oSnCnOhgtbZCX+GprKR
         MCCm9p82GIPDqwdmeU6kTATBaF8hKGBTeFcdh4q6S9N0QKzLrXRhIeCZdP24ZproHCdM
         jfT3PRm7y33LODwwN0JAnNpN1VdECvKkdAkcnJLAQvKYtPjSC1BMDq2dLyCKt/U1ZHDg
         P0h9ZMG2hPv3QBRxxrvbayGsOLSFPh4MuEK7sWji/BDPFdh2l2t2D0ZWmvV8qxVJF4Qx
         gGQg==
X-Forwarded-Encrypted: i=1; AKwUvBzzlKG1NxYSdtwS8ECUe8QNbvDJV89nkdPIW+skLoygvyAhqg/l78kK+TtbGoeTf5AjRVe0VA==@lists.linux.dev
X-Gm-Message-State: AFq9FYJfBTGbkbHWn8pFKclUu7JTMp/HZ3s6ZcKDlHEcXJzcCcTVxuey
	jwG3RV4t+cW0ptNSqDPTgzjvq3R2CIjdi3BAcZLBQbKkFtXVG1JszjiR
X-Gm-Gg: AYBFou3ikmc80ZXoRByKXk2gaSGq0UhS8+uxmtjQWfRKKijDnl+nftYjOYQtqZWs8QM
	1aN3a6JQ1vh6gGO/lwFKaLmTZWERcjlRZWOhqonPxjVc4Z2KJ7atKUB5KCQBx9RNsSbHmx+vbx7
	MZvuIU6+q0p5g4gbJjDMMUZOu64KkjHBlUvmIKhfHWw+C+wAcuxmtevfT5umwydKA4r+3G0Nj6W
	8MxX6bH40DjK5G5iCEymBdKgNbVeZinYx1t5naDRhJ+hTCC6bUPxgV7aB5MlD3l4dFkbUsIs/9K
	iCmX0O4ywJIuENzAqvVFh0EHldse3W3zWfMUFRB3HjffW4Pgt6atnSsLNICPE2Lv0N6dzu+Rfhp
	iQqYvarSPp8XirffPcfoCBUrQdAhd7LFXMVKZsVwlqy7A41AxTSRzhViKOTyQMGw11rZq8fL0kK
	Xkfdhuc5QJEGOC55jjs6WW7UgCyFxnc3mwrqo/qRhb+L2T2ya4sNnbSKAkfVaKs5as1RCOoJDWE
	IEt5tbw5oDYEre/e4pzm3JHZAC+kQNR8WaGIk3dTHF3JuQpDfEpOQPUnFje189qV8kJKOmv+70m
	fcb3CaTs+ldRf2OqWgOoSnUHQMGe2SGes3o9BvvkTju6OXMmeitt
X-Received: by 2002:a17:90b:3b45:b0:3a8:7096:9b48 with SMTP id 98e67ed59e1d1-3ade9b2cff5mr7922722a91.1.1793069265598;
        Mon, 26 Oct 2026 19:47:45 -0700 (PDT)
Received: from localhost (n106-71-19-159.sun21.vic.optusnet.com.au. [106.71.19.159])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae404426c2sm1518262a91.7.2026.10.26.19.47.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 19:47:45 -0700 (PDT)
From: Aveline Noir <jm5905938@gmail.com>
To: SJ Park <sj@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>,
 Manuel Ebner <manuelebnerli@mailbox.org>, damon@lists.linux.dev,
 linux-mm@kvack.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/8] Docs: damon: fix grammar and typos
In-Reply-To: <20261027004916.160854-1-sj@kernel.org>
References:
 <179301327249.2.4690198998605536207.damon-docs-grammar-0@gmail.com>
 <20261027004916.160854-1-sj@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Date: Tue, 27 Oct 2026 13:46:00 +1100
Message-ID: <179306916017.2.12297411301652219760.damon-docs-footer-reply@gmail.com>

Hi SJ,

On Mon, 26 Oct 2026 17:49:15 -0700, SJ Park wrote:

> Are you intentionally removing those suffix, using 'git format-patch
> --no-signature' like feature?  If so, any reason to do so?

I was trying out my own script to assemble the patch emails this time,
and seemingly I forgot to add the Git version footer. Thx for 
reminding me that.

Thanks for applying the series,
Aveline Noir
