Received: from mail-pz2-f41.google.com (mail-pz2-f41.google.com [74.125.228.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C8E42C11CF
	for <damon@lists.linux.dev>; Sat, 19 Sep 2026 07:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789804475; cv=none; b=VexXY7chaVX3WMvQDUpIdDxI5fvx+XcXQ4FK5iqIOuwr1+Yi+zqFAhrpwdoVxlGGcnVTAouMArMaf7aVfdNSoN67HFUr2F8Y42RhGeWyvGF2Uzjybr35SAqSYsKoaYkJkAt5XFWiEn55w/+f0cvIY5kQKeGE/f1wL/lF5PGES00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789804475; c=relaxed/simple;
	bh=2kE93vf+E3ruEgQHNc53eCH2AaAboJRcqDtn7P7XdVM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OU+32qGTqOZXfUL3AaQ9s7T3pSFB7IwjFkepBA/RWhvYT46T5Emi4W+izQo8y4T/9U608zUJraSl/pJyaIl4AoQl93kcN3xs0LRdKEzep8Bu1Sgo6Xkz/c+oLjKtMRMuW4FLVl0tFYA8q50oZjdJaBBbaAZDDND0vbDIgKeFDFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kQHQTtMn; arc=none smtp.client-ip=74.125.228.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kQHQTtMn"
Received: by mail-pz2-f41.google.com with SMTP id d2e1a72fcca58-85469a34907so1719191b3a.1
        for <damon@lists.linux.dev>; Sat, 19 Sep 2026 00:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789804474; x=1790409274; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=J06q8hxVr93lubHITldJTNiWnSDZLX+yOQxaNg68pLw=;
        b=kQHQTtMnWam+Umdgda6fXALV4oSl2GOYiXmOeB/e2+bCY7HestPz90KZI+nH06jptY
         lNwkOLV9Z5whCNFR1UcxszMaErvVg+d1jMlqeQ+4ydk+zudWDdBFeL/kBlX0eVt0bFOv
         Tk0IX806QpO49p+hf8CXXk4/7hiHtPzqgLic7XbauONw5StTh45FrfsbHHrpWNAIq8kl
         Lr7MxuXBZ8GK41dfYmHzJLapgLQzZ9e2970ieE+qmKTu0+fjB+rlXdf7vd1fqDf2c2jK
         2ePR0ft2+Y4oFt7kD8msTlAgOhwnRBNcYRh/sJkCIzooVOFO5KcicGSrwlExTQhK1gay
         ogDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789804474; x=1790409274;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=J06q8hxVr93lubHITldJTNiWnSDZLX+yOQxaNg68pLw=;
        b=EvMsl3lqexKLVcbJJHw+S/G26qk4K96qphHoWaES9GZ8nS705vK9E4cp5u+BraVm/b
         Vr/+8qRyYefzzv5MY/nTRvuCfM6itlPGfojmOrBJuQQ2zklqbdlkswstkSrrBb4cTIAb
         rvpqd4vQv9fJIbmBbTA26uhSoHMdXRWrSyh5ra+41bZ98w+Gd2Jmu4GkXRUr/Sw67bXz
         nh1VUQmc9cejE1aubvYyybPHIFP3B7fnjGDdLYMBvgO1CTChlqvnfhzcDcuJCYEZW06p
         SWtWy6QQ0hhGRHFxfy3q3czpK7i+oLfqshhi1OYz47qcana01Pa2usOTbf1iZpkFXM3a
         PbeQ==
X-Forwarded-Encrypted: i=1; AKwUvBwIlCSc6k6U9NCF7G514WkjxsQj6doVisF9lV7tztMmE0RvAmHYU97T1O6aPiUi5kkEuZW5DA==@lists.linux.dev
X-Gm-Message-State: AFuF++n/olE9wQZdC7rYe2I1+xVzOXojrCXHwJt6PuwthcFKHr7pSi/G
	EkOWN5uzIsrrX8FMV/k7tXo2uenX8J+rF0+COU1Bo9/tIX476bmHayvJRv8QDg==
X-Gm-Gg: AYBFou0zyr2wheiDMq33wqtY3U+h7zrSTH/QQEXIvM+Mev3z+9ubE0HayzfSBU6k+FI
	ABivIXdZNc5V311rs1ZIphp4PHCg5ZDID+QhQL/GNmT82RD0A6DT56mn4+ajEvdnmFAB0oIgILz
	5qRG+Rfg8HAPh1Seg4oAoQFBvQ0MEPEr+Xz0ND/2vYTA44IfSFdAsjjgGhxscj8NThnXd83n1Xd
	Z2qLnnx6B4C0OMWceo68z/sBtUI8bgBlNO0+MKiPQdqLUAEL6Vr1HtIkGatUUyY+dtnPHjoDegF
	7E1yZUm4wNqvM3tRoO8vtDYvxMCW3K5ugwhIzhBLycNICECX/+/+FaD2ubBevYatp2dkZb8JTik
	wOBwW+Qja2qHqrIImp6+uJG7L5eDzxHOszXIin78XubOhdkfv39zgSL9DW/GxkHGqGy6g3lJtsN
	MuIvWaP5jb9nHdGZ8a31g7Rp2QtrEaar1eP/N/MEGUmTbHEJZSvwYlegXib15Tdmc1hAORfSXWj
	qMtUjTYw+Pjyg==
X-Received: by 2002:a05:6a20:3d8b:b0:3d2:2011:d184 with SMTP id adf61e73a8af0-3dd8c442440mr9560107637.14.1789804473615;
        Sat, 19 Sep 2026 00:54:33 -0700 (PDT)
Received: from celestia ([2402:1980:c3f:8e4f:9945:ef6a:453a:80bc])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc72ae9e9bbsm663791a12.16.2026.09.19.00.54.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 00:54:33 -0700 (PDT)
From: Liew Rui Yan <aethernet65535@gmail.com>
To: sj@kernel.org
Cc: aethernet65535@gmail.com,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [RFC/Discussion] mm/damon: Implementation for paused kdamond
Date: Sat, 19 Sep 2026 15:53:54 +0800
Message-ID: <20260919075445.627288-1-aethernet65535@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260918024506.13715-1-sj@kernel.org>
References: <20260918024506.13715-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 17 Sep 2026 19:45:06 -0700 SeongJae Park <sj@kernel.org> wrote:

> On Thu, 17 Sep 2026 23:31:53 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:
> 
> > On Mon, 14 Sep 2026 17:28:35 -0700 SJ Park <sj@kernel.org> wrote:
> > 
> > > On Mon, 14 Sep 2026 23:35:10 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:
> > > 
> > > > Hi SJ,
> > > > 
> > > > I noticed that the current implementation for paused kdamond is
> > > > periodically applies online parameter updates by kdamond_usleep().
> > > > 
> > > > I'd like to know if we should change it to waitqueue to achieve a lower
> > > > power consumption?
> > > 
> > > I'd like to make a data driven decision :)
> > > 
> > > > 
> > > > Previous Discussion
> > > > ===================
> > > > 
> > > > I noticed that when you introduced ctx->pause [1], Sashiko asked the
> > > > same question, and your response at the time was:
> > > > 
> > > >     "sample internval is 5ms by default and recommended auto-tuning
> > > >     setup makes it hundreds of milliseconds.  So I don't think such
> > > >     change is required."
> > > > 
> > > > I'm curious that, did you think it wasn't neccessary to change it to
> > > > waitqueue when it was introduced, or it wasn't neccessary to do so even
> > > > after it had been introduced?
> > > 
> > > I guess I thought so when the quiestion is raised.
> > > 
> > > > 
> > > > Asussmption
> > > > ===========
> > > > 
> > > > This is just my assumption, not a real use case I knew:  When 'pause' is
> > > > set on an Android device, user might want DAMON to stop running
> > > > completely when the screen is off, thereby reducing the load on the CPU
> > > > without losing important information such as regions and age.
> > > > 
> > > > The current polling may make it harder for the phone to enter idle mode,
> > > > resulting in some unnecessary power consumption.
> > > > 
> > > > However, pause feature is only present in the stable version v7.2 or
> > > > higher, and since the latest Android kernel is 6.18, this highly
> > > > unlikely will affect any Android users.
> > > 
> > > If whoever comes with a data that require changes, we can discuss.
> > 
> > Thank you for your clarify.
> > 
> > I recently backported the pause feature to my phone.  However, due to
> > Android's screen-off mechanisms, I wasn't able to obtain any valid data
> > during testing.
> > 
> > Since we haven't identified any practical issues with the existing pause
> > feature, switching to waitqueue isn't neccessary at this time.
> 
> Thank you for checking this.  I agree.
> 
> > 
> > Regarding the documentation, should we explicitly explain the
> > relationship between 'pause' and sample_interval in the documentation?
> > That way, users can adjust the sample_interval value when using pause
> > feature based on their specific use case.
> 
> I think that is too much detail for normal users, unless we find a problem from
> the lack of the documentation.

All right, since no normal users seems confused by how the pause feature
works right now, add documentation isn't necessary at this time.  Thank
you for your guidance.

Best regards,
Rui Yan
