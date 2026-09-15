Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61FA633939D
	for <damon@lists.linux.dev>; Tue, 15 Sep 2026 21:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789507868; cv=none; b=qvPQjwET9Q4N25bQz2xyYQw+1gYFo0CgsT4TkFB5TexFqVto/jwOR8108IO+SxCLaByH+9ox+xWz0M243GeC0aOB3C6Speqlk/GF0YXLusz0c+WuwvKn0FrVIYYdyoJg684WzW09bJz+qi9ToGL2nNQZGLI+R2jGHessqoRFlrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789507868; c=relaxed/simple;
	bh=hxkVFZZoMQECY3fDO3cdjGvVbbJxX4hdwI6RfZfrqKE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b9cMbY4ilXk5aCHEwn4qGftzjM8GStwDnrAFliKtfQCBFQzXgsCpHWlZ32fZPcd5a0iWXpGz1Zf04Pv2Th1a/XGJzxifhFh9IoGbF70QNBinoS15+53o2MajNpieSU7XgFrR8Kt3K7yjsX6fIs+mDboUyILDYRXfr4jvcnRhFeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CxqUI4n5; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CxqUI4n5"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-482f6351831so93880f8f.1
        for <damon@lists.linux.dev>; Tue, 15 Sep 2026 14:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789507865; x=1790112665; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=f43s6nsHY5Ivj1yPDbhwSaNlMFWcD03sTjXZTf3Cl8Q=;
        b=CxqUI4n5llFJ+IWf/S8j++tCLLACqeQ1Cw26ErZRuw86fdnp5g5wTZFCj+tnWcq29N
         ME/SkytPlpisPVuabcHyhhQjqnFQKl8d8an5AK7lS+g3gmghI8gAjLVjmtXtOQj6g/tT
         Bx0mVr3vUAu2VBdEMcIuiYLBoexzSW6PKS7jxhQbbC/853bcszz1dz5gDt6B7ppbagYB
         /BB1I8U/TYTO7XNQJhyrCLiW8WIh1sJUbCX3QSl5YnIv30BYoNONOE8Gc8ClBGXVH3rG
         zeIo5BTN1UJB7LdlnXLOxA/XFAQyC1W1jwH0WzPeqgttqKQ0YiuqgA9FwqGAmuYupusY
         vBeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789507865; x=1790112665;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=f43s6nsHY5Ivj1yPDbhwSaNlMFWcD03sTjXZTf3Cl8Q=;
        b=1HPZDr5PVR1Ivio7pCoe8fGRjsUN/SFnGS84QAWjVDPDuEO+GFVnhxv6O+ZRnvMSqt
         NpfHa7eruRsF9K0LDcWxvMTjMzgwRuLGns6A7uYLAWziyggItdSSeMg/BebGS136RZ7p
         ROZFwGuYyUbdltdJ3fSraYq1EO2yRxRNK+RsK2NEQ3d84pg455D/5CirUujAamWVP7IA
         rhVJq7Ko5KBWnLkAm4l/Pe+8jLcLKFdbptwEQWBIvNRn8PLDjaKoG0oHDOBd3jsngkYv
         HybI6xPXLzr08p21BARGg6dfq5W2hO2nJsWwmtzJWoZLZcSa5kkwIBk7u7yYW+ZmKcac
         IzYw==
X-Forwarded-Encrypted: i=1; AKwUvBxTAy492Zdol0FyoTKCDVYN6TJ0kKMhGbRrAZo8Rs81VBm2eNHQIbkPTv+CiM14jjPkQtCI2Q==@lists.linux.dev
X-Gm-Message-State: AFuF++kl6o1uXmsf1IVO6ze4stzUOb/gSoFJZETamgpDe8uKmScoQpKm
	9d9toYeceOsm3KCh3YACquc0OiEPKwCejUY5/MTMpYelTiYSnPR7yiH52HavEg==
X-Gm-Gg: AYBFou1sNlKtyBCws6bfS0qw4M2TYFOIsq34dGa2aFNKC+m3DTABrIjdrMhuX8hn07R
	bvrTxTf/7u4bDByryTR+m1pUVQc2ihPhM/BW6Fli5xrgvDztUfx868tCViPuhuW6puaFQRRRwxf
	dHn8aaKDKqJz7Kpwr60gOZbxnLJSi56RQT1gwTboorrD+thFl6l4eiziwFsaSYp0VisUCZoQ/pA
	15fdc+RNcDozL7kMXvN0l89xYyAZp8P0mlimBWVe0t93kEhMeN5fm+2Gy/1pA+1qwDwQ6k0SnAH
	CLXZ0AFY4tGwlIR7yaTDr/VB0Yqcx4nDgCU8k01ioPaSjoEdzCLTR9wlS+Q+R8IPW1hAN31xUxf
	MdWCoORswbyIKmZcvrXv0vfuDoVBuHwdbJYhtfMozMBG30+IYU71mOJWJ+6EtQe7G456sndoVDq
	6MYVW6S4hUyzEqDsZJvAo5iYUPQADUgdhKmAwKmWkU2pqfIMLgPXkaZ0qN/K1MlDUFFiGQxXrdx
	MtXfu6iaoUZgsWHjL4qyyPovVvZI+s2XYb9+TSk979uwjW7w5VDbMH3nnkw2+7EVxaQRUqYhAZw
	/TcoJXwSDZ8ZVjTVGjI3eefJjPZesSZEQexNP0LCOTdSU5F6Ch5ZVr5o0IfJRbx77tZ0p/sf
X-Received: by 2002:a05:6000:400c:b0:486:e9ab:2b86 with SMTP id ffacd0b85a97d-4870d0717damr254328f8f.39.1789507865223;
        Tue, 15 Sep 2026 14:31:05 -0700 (PDT)
Received: from MBP-von-Karl (dynamic-2a02-3100-afd5-c801-ec9e-1a2a-2fc8-3f88.310.pool.telefonica.de. [2a02:3100:afd5:c801:ec9e:1a2a:2fc8:3f88])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4870bf43511sm1713554f8f.33.2026.09.15.14.31.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 14:31:04 -0700 (PDT)
Date: Tue, 15 Sep 2026 23:31:02 +0200
From: Karl Mehltretter <kmehltretter@gmail.com>
To: KunWu Chan <kunwu.chan@gmail.com>
Cc: SJ Park <sj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Lian Wang <lianux.mm@gmail.com>, damon@lists.linux.dev, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] mm/damon/tests/core-kunit: test PSI goal rounds
 under the temporal tuner
Message-ID: <aqm4xSben7Aq1iNO@gmail.com>
References: <20260915060937.3423-1-kmehltretter@gmail.com>
 <20260915060937.3423-3-kmehltretter@gmail.com>
 <CAN_Opa9rS45S_MHbmf63KC0LY9AGAdAC5r=vv_qcYMVAenWosQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAN_Opa9rS45S_MHbmf63KC0LY9AGAdAC5r=vv_qcYMVAenWosQ@mail.gmail.com>

On Tue, Sep 15, 2026 at 03:04:06PM +0100, KunWu Chan wrote:
> Could we also check goal->last_psi_total here?
> 
> The first tuning round should consume the U64_MAX sentinel
> and establish the measured state.
> 
> Testing this explicitly would lock in that state transition.
> 

Thanks for the review, good idea! The test only inferred the state
from the effective quota, a direct check of last_psi_total is clearer
and stricter.

It also fits the v2 fix. I plan to keep last_psi_total across a
commit of an existing PSI goal instead of touching the tuners, so
that value is what the test should assert.

For the v2 test I plan to check last_psi_total at each transition:
not U64_MAX after the first round, still the kept sample after a
commit of the same metric, U64_MAX again after a commit that changes
the metric and back. The quota checks stay to cover the tuners.

Karl
