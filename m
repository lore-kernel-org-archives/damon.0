Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50DD62512D1
	for <damon@lists.linux.dev>; Mon, 23 Jun 2025 19:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750707521; cv=none; b=JGL4N77++bAEAAAM1CE5gcEzfIHGL7H7xR6xRNJs8+kdv72WUqbTSNIHBdYgDDiQSbHi0N7KCT5LQZGKlpcBgnpKTjnGQfXN+ZqNkMlSftGKMunC5NIYmXEI61Tq9JG5eMcs+YdfUw3QDwr8Z4g1QFobojhom6vxGyZLagEMj+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750707521; c=relaxed/simple;
	bh=SUcO28iflARfNEkJ1ohNxfXTZlHppMemTQUfxW2VsWA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cGflDKLNya3z5SoqBNT6cc8wfky8OfBlBdDChJSaibdKzdfNQ/nymZ74XKZOG2h4/vveAYUD5++CMyI09SBIodMeyUPUz9bDqAumms3Tcx7hyolX7TK0B5+EIKGqDuZZQGJPWUUZ0oS7kta3QnGjS5nqbTRRkQS3X9qSx1tfJK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=EYqgD8Vi; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="EYqgD8Vi"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4a44b0ed780so59289291cf.3
        for <damon@lists.linux.dev>; Mon, 23 Jun 2025 12:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1750707519; x=1751312319; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OsDFFNadcPKAi2oIob212fTkg2LjML9Ql3EAFUmRUHU=;
        b=EYqgD8ViMnEyR6bYIknn3P4OP13kJuzaCGngtvuPOKjGKgUxtW8F+A2NQQONqnc77b
         iWJt+WuBhNtnI/qWs4yCH6DtgxbtZiW03+OWJDsxeTuCx7hoJb9HghrTjB4gQBP9+0uB
         Ag4P67/0i1wI6tzY3tKSO0Vgrx+gtQHHqBva5b4M8hPo1erDTN70nEOSbPs5u7jz5uCJ
         r90njJnFz1uZJVQ0GBD4uSnh5h4CE/njP1gyPMtAObABXwPSOH0U3QdsNVT/eukR7zY9
         4klrXqu0tQuEvSjo4Pn+56q2i4zSGeftbcxyxwTX58UB8kML4jTTCMwgyulVIHTZaCdk
         rkkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750707519; x=1751312319;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OsDFFNadcPKAi2oIob212fTkg2LjML9Ql3EAFUmRUHU=;
        b=tV4IKYxv+lnrejH+HMP7eYoqafn8bv7P/kov1hQQ37L2tlEJOhPGIV1XTA0MlncNB+
         Q4xvpHwMQqlux8eYmwHngKRnDQcc64mRNyxu30nKpWFV6NYkX0fGMDbPQzLMJkI1blId
         WS9jRt7BXaY6oO1ftz9uNsEUP0VdvIKUoOYY407Z6ngx1Gb0/374Vuis/pcj0O/CwaRe
         LnBgExCxsFVNYdYZk6SzFyJvh30CkAIUe7CgKPolx362rxvFjEZdaAlWujqDYNyO60bI
         NpuZZpHP9C4rFBANNK+ys86cneJ8zPteG8UxIHO6QMF7EY9yUpF2I/zyXGlIKErOXU8C
         SICA==
X-Forwarded-Encrypted: i=1; AJvYcCUqftMyjXgghdFPssgSyhOWx+ga3FaFpe1/PZV4cnb+Hbjs7lbrT6KnCkbjikhJ4zLybWNIIw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwbVXZBtIVvI9gtN3ieTWu1x6dOFRVZ/CqVcxLddDT41SU0VBBq
	7b4nFUvm5s/v5Qt4J6ntOQXSOhrLvS8s3Me9j4PiuDDJwooPYvqR2tTZlbSDD6ROZgU=
X-Gm-Gg: ASbGncuOnEb4jvpXi5posBS10/I3bVGdmwHi03fLDulumPjtV4G10PEgj5z+NPH6PDk
	t3AM9/nS39uca5Au66kths+YC2xt3ebpt65XA14MpPo5YFmcyP3ttzXrZzkJpXMTSQHmvHwKzmz
	+avUuBWvX8FIn/c9HJxT3NfSUOA2opvNNdpeHjlELijOoQFc3OCXBSxk10hQChS02kuY+ngL5ea
	D7IhiIGn2KrrhbzOtbZPTKitECReiqjruIaGguhFOUGfr6BVEsosZHNR0QuBTnGjDgDTBSRqugS
	VAergwJA0juoBAAOy2fto8jaFopSSphkiFbzs3rkTV5/KHpsthpdM2Azaw==
X-Google-Smtp-Source: AGHT+IGEe4owoKuwDVOewVa/4Edect3j8Yf80FLCWoMblOwP+OBaPb93AZugTiBwPwwRicj7AyEi8w==
X-Received: by 2002:a05:622a:13cf:b0:4a5:8387:8b9f with SMTP id d75a77b69052e-4a77a24bc82mr181710941cf.15.1750707519236;
        Mon, 23 Jun 2025 12:38:39 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F ([2620:10d:c091:400::5:e19e])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a779e956bcsm41726641cf.74.2025.06.23.12.38.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 12:38:38 -0700 (PDT)
Date: Mon, 23 Jun 2025 14:38:36 -0500
From: Gregory Price <gourry@gourry.net>
To: David Hildenbrand <david@redhat.com>
Cc: Bijan Tabatabai <bijan311@gmail.com>, damon@lists.linux.dev,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, sj@kernel.org,
	akpm@linux-foundation.org, ziy@nvidia.com, matthew.brost@intel.com,
	joshua.hahnjy@gmail.com, rakie.kim@sk.com, byungchul@sk.com,
	ying.huang@linux.alibaba.com, apopple@nvidia.com,
	bijantabatab@micron.com, venkataravis@micron.com,
	emirakhur@micron.com, ajayjoshi@micron.com, vtavarespetr@micron.com
Subject: Re: [RFC PATCH v2 1/2] mm/mempolicy: Expose get_il_weight() to MM
Message-ID: <aFmtPIAYnp4oeAZ1@gourry-fedora-PF4VCD3F>
References: <20250620180458.5041-1-bijan311@gmail.com>
 <20250620180458.5041-2-bijan311@gmail.com>
 <0067568e-a604-46d3-96fd-41b62968a90e@redhat.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0067568e-a604-46d3-96fd-41b62968a90e@redhat.com>

On Mon, Jun 23, 2025 at 09:14:34PM +0200, David Hildenbrand wrote:
> > +u8 get_il_weight(int node)
> 
> The function name is shockingly confusing when used outside this file. Do we
> have some namespace to at least highlight what this is about?
> 
> node_interleave_weight() might be a lot clearer?
> 

this is fair and my fault as I didn't consider whether it'd ever be used
outside mempolicy.  So i agree it should be renamed or wrapped.

~Gregory
