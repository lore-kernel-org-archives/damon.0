Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 083CA1D9346
	for <damon@lists.linux.dev>; Mon, 23 Jun 2025 19:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750706922; cv=none; b=P6FxZzBl7kdmeCLWNlH+4pypzlYUICKMTNR/zKe8vmmgIsNgvXVs43dBR+pfMecapIuINieiWXkF+WKGj70rcUUgySu7156F8zoPhZEecd+2LWbaxWdNiHmRc00hkwFx3qi90uzfr+14Fa1urjexe1DUFBONbESF/OIz9JnETtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750706922; c=relaxed/simple;
	bh=WRJhD+11S9GGLV+fipKxjCq+9EZNj/yOwmCQ0iZsxkw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ertZKnrFfJ096bqM7POZqFrmuiggYZmSY6pvBWY4ZUtW3BiMZXk1FDHDySAe6g45PzxdXxqTIDpEC9+l4shwo0KXEqriqob/Rvgi/+aciSyLTDxu8QmNbGFB2JnT0iogayxEsuqJfbBwdB2G8doVVRYtERKsG1iaUxLq9GjBegw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=pt4Sn4CA; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="pt4Sn4CA"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6fd1b2a57a0so18281166d6.1
        for <damon@lists.linux.dev>; Mon, 23 Jun 2025 12:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1750706920; x=1751311720; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MEleCZhv9arZ2pHi+mURkLxlUm45MBsyjbMIJWAnz4A=;
        b=pt4Sn4CA+oarPPNTkbzbrU1Em/FRqVToCgWOWYc/od3h0Mgnm37BBZQJ/z7hDet9OX
         3gPDVUAFGy0+ad8uCqG04eNenS56PSsyIseaqVqpP9CRYr1anydQ4nTejNo+7bHbxQ3J
         khapBUx9Uqp2F91AG0fijwIGcDvWrNA7kTrBtJTHuSkqznRcaLw38jg1GQjV/O1wB2o5
         tQ2Fw/o9iIN3NGj/YXbyzatAVf3vVJxOB9c/QGKwEOOJTC6JNnHnZblMP3BO7DW3VvW5
         f3JD93UGXxghn/iD4pff6t90zQtsRJLMGVOUCISckr8kZnnAyFP48tUBQT5mTLG+5MLw
         Cuew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750706920; x=1751311720;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MEleCZhv9arZ2pHi+mURkLxlUm45MBsyjbMIJWAnz4A=;
        b=mHRyUTaQYyLVqpO/c72C2ewmEsIHX7Uk1efONMOlgqqSbMkm2WTTsgTCStRVwucYaX
         PRENhHsVYm9jWFObIDlZcISGVXDX74eVws9ZM/UwNKhVR+iFKk5+qWAgCTuOcRIEw21z
         MEI2kOEisGIj5YzVEGfzW5gQJXLEinWh88AsuKYTqfFMUUgbcVRniDMx4bQAZpa+7HHQ
         eYf+jHYjzUQTBFrgAbOa1J02Wrp5uQmTr/DSMqgagevlc5jE+JSI/6TXRwhhATCrU+ut
         utnn3KU7PF4V3tIlq7UeIE8ZwruM7htVfVNi+W9+pHs2mus4ZGGDQ2p6GgP0jB8TKqvN
         NqZg==
X-Forwarded-Encrypted: i=1; AJvYcCW5npEn65ME82XmRpUka6tJULKCPxcKjdVj5mhvBp5quWLNXZocUfaVUEgGcaV/RfgrheA8cQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx7Oa1nI/d0okdzl4zGnu0O1Ia+KG88eKYPq57INk4rQf+0kW3x
	fvtR/UQYhI3pDz/4256De/fKQ4STA5MwZbd2XMlq7v1zRli6vftHhk2R+XMqksKOl4M=
X-Gm-Gg: ASbGnctxckQAps/yVzUkymRk3rbF9tlbNJKFx+CcPiX6i5l5Sc+bhWDdjm5eufk2J4e
	O/ytbA2pm9vDeLuW6V17y2VTdLgqDJ2EJW1F3s1qTCIA6FFv5FDf5k7TRwChky5qOYJuUis4EXT
	QqN8Fzcb6paSJqfjPMu6K3R7x06jprwV1UlgcwQMIRkOUT76xT3Ie7UmtUKFHRNvidtuezCAWRw
	g/8DuDf+eSlVL/fNfl5v6ywSHLR5o3t4I6u4rsfn/oHId0Rkjyx1c3u8ZLpqteOQ5vb6hCOOJ+q
	tPk5fIS4pf5/zzn1Ex/4nDmwjkNc314slxUJb/eMMllA+rE2KqCfUuYB0A==
X-Google-Smtp-Source: AGHT+IFddekhlV21epL8woHsqfJs9UDhRue34bYoGICu7apONYW2ZhncpK6K5u+JV8Xd/GANARdn3Q==
X-Received: by 2002:a05:6214:500c:b0:6fa:ba15:e8a with SMTP id 6a1803df08f44-6fd0a468685mr246211096d6.8.1750706919931;
        Mon, 23 Jun 2025 12:28:39 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F ([2620:10d:c091:400::5:e19e])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fd094330fcsm48301596d6.31.2025.06.23.12.28.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 12:28:39 -0700 (PDT)
Date: Mon, 23 Jun 2025 14:28:37 -0500
From: Gregory Price <gourry@gourry.net>
To: SeongJae Park <sj@kernel.org>
Cc: Bijan Tabatabai <bijan311@gmail.com>, damon@lists.linux.dev,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org, david@redhat.com, ziy@nvidia.com,
	matthew.brost@intel.com, joshua.hahnjy@gmail.com, rakie.kim@sk.com,
	byungchul@sk.com, ying.huang@linux.alibaba.com, apopple@nvidia.com,
	bijantabatab@micron.com, venkataravis@micron.com,
	emirakhur@micron.com, ajayjoshi@micron.com, vtavarespetr@micron.com
Subject: Re: [RFC PATCH v2 0/2] mm/damon/paddr: Allow interleaving in
 migrate_{hot,cold} actions
Message-ID: <aFmq5Y1zKov9__zh@gourry-fedora-PF4VCD3F>
References: <20250620180458.5041-1-bijan311@gmail.com>
 <20250620202155.98021-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250620202155.98021-1-sj@kernel.org>

On Fri, Jun 20, 2025 at 01:21:55PM -0700, SeongJae Park wrote:
> Hi Bijan,
> 
> On Fri, 20 Jun 2025 13:04:56 -0500 Bijan Tabatabai <bijan311@gmail.com> wrote:
> 
> [...]
> > This patch set adds the mechanism for dynamically changing how application
> > data is interleaved across nodes while leaving the policy of what the
> > interleave weights should be to userspace. It does this by modifying the
> > migrate_{hot,cold} DAMOS actions to allow passing in a list of migration
> > targets to their target_nid parameter. When this is done, the
> > migrate_{hot,cold} actions will migrate pages between the specified nodes
> > using the global interleave weights found at
> > /sys/kernel/mm/mempolicy/weighted_interleave/node<N>. This functionality
> > can be used to dynamically adjust how pages are interleaved by changing the
> > global weights. When only a single migration target is passed to
> > target_nid, the migrate_{hot,cold} actions will act the same as before.
> 
> This means users are required to manipulate two interfaces.  DAMON sysfs for
> target nodes, and weighted_interleave sysfs for weights.  I don't think this
> coupling is very ideal.
> 

Just tossing this out there - weighted interleave sysfs entries *should*
be automatic, and the preferred weights shouldn't really ever change
over time.  Even if they did, if it's the result of devices coming and
going - the updates should also be automatic.

So, in practice, a usually probably only has to twiddle DAMON.

I don't have a strong opinion on whether DAMON should leverage the
mempolicy interface, but I think the way it is designed now is
acceptable.

~Gregory
