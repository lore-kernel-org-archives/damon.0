Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E605E1684A4
	for <damon@lists.linux.dev>; Mon, 23 Jun 2025 19:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750705572; cv=none; b=iNk7TEB6nm2bEgBglzE7Nc/sBSFUp6flAlIG1PaNdnDXZlLDa2869bNXfeH4Iimw4xXsTws1HdxPmHfDxUJlpb5Y28IP3xHD03wbUeOxwRAr0iFRLqEXBPknwsKHC7pKxfk0lDEXVMnV5JSZsJkJFpDX1H4zhdwsviaOppVyFyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750705572; c=relaxed/simple;
	bh=3bOfK9tvYoyS32c76foHmKh4Nx/kpDESMgccvA7X4rg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ga5CAZ5xhC/Di5z8g8qM/67t+yNSg6zQp3PvHHN4DJHd3Uj5zOGHtuuDxbtCeELn0KRZpKcGGoBxyS3MBZAu1ZbKgVrkDzMC1HWqoRNeaAppTtx6B7r7xD/j2rokS4u6ASdO344fnxniLkfWDWlUh7wdfm59nAXAI66IanNDH1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=pLQ1Apwc; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="pLQ1Apwc"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6fae04a3795so51029356d6.3
        for <damon@lists.linux.dev>; Mon, 23 Jun 2025 12:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1750705570; x=1751310370; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lxtXCdFFskodxZfUDn7ahA5cQvmoiafw7SnR22JSkSM=;
        b=pLQ1ApwcK//6D8BtJHsmBX8yDM7p/2bZubwHQGEYA+vS3isPGctMTMsSnC2VQEdV/G
         jB01xwPmdqfk60xleA2GUFaPZa3Glp4brdXjxW9LwAlK7zwmfc5s3BVe4Yqlrtn5hfvy
         O5iRPGTsbeaZzA4wiu4aXJAo5nffbBEKvox0DFXOR/UjBFNTA8iphHsM8RtYhyvPWOPB
         6v/vogSdXu+yQWyP6+BKC0+yDFcYEf0/G0nucL0W3QlMB5ef32cIQKvAKhTAWrEdfsPT
         G1jin3tmdsdJCANEw7ZDeTwHFYtrmm5eHo+ilrdOfm6pcV0trIwvBLWzGTe/C9mZYmd9
         BypA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750705570; x=1751310370;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lxtXCdFFskodxZfUDn7ahA5cQvmoiafw7SnR22JSkSM=;
        b=jFbHgt3WlEHCWygbs47p99uiXrkL8fcKSqW/loSa8ZVGNbLVQdhRst5VPPkNqAZoxw
         DLHXlQ7+UOem9eoircMmZhICD3w7gVvDJtIWwiau+tX6ZEKDZWqLlSScutKvkXze+84v
         3DKjTVuyRHXPChQeviW40sPzo9csKNQ6qgQbxUyigLiyNaDwRMXNjnc+lmu1KGBuhYbM
         qytLF1B7rteNlQUfRiexIo9XQKm5wIe2j/EHCVN6MH1YrIVHG6ZAQPHjSpawYvbcc15L
         zkceR54Lc9VBgoqVOQfcE4hr9HNH4UZJn9Z7zKALu2Sc+OzZYeZ1dwV/SWwzfHa1NA1O
         ZnzA==
X-Gm-Message-State: AOJu0YwEyG7l9W6Dq8ekvK+kCK282z9PhoKwuuPg8pscpUXCRn1BTc60
	6s6+kH5yZeTrekgmMdAhp2bNKhmRBbrqB3IoNYViLytN9DqJEgthcdPupkdeaRy2NQY=
X-Gm-Gg: ASbGncs8dt9y730hTB4SjyrwBj2epd3e3EdpiMRhqQ5ohn+/WKGEH/Uu7agxf1rioOA
	Szt9JYmd2m3mfw8M7xn3a2nLwrGDzWLyX+yxIpcyL/dCknPlEuZYcL2GeN9lPaqCzJpj4g38+8r
	KywXfn6u1I+GwgdgyV0gufkNtlaYzxkpaOFj4un02tUYnfnA2cO7rSJnuKhy9S577zyY2TsNceJ
	cV4o/kaw7HG9HndpINQiM7oybXRcp4iEfw2D0rarjKv69iVB6EofHoJmVodTaQ/X3aE4MNV6oNQ
	A6KFGEArSr7TUJPejuOlJmm6MwWfzS3k0wJaXkwXfVkJHGylWFJ8ro2CLuxOSD09EnYp
X-Google-Smtp-Source: AGHT+IHKfvbJCKgRw95/hYlzipmhgWo0bFzDAVi72dVhWbrFTXEA6+zicJGy7m3eDM/cdLV9FpbUog==
X-Received: by 2002:a05:6214:540c:b0:6fb:4e46:7f3a with SMTP id 6a1803df08f44-6fd0a4d68f5mr258869806d6.16.1750705569727;
        Mon, 23 Jun 2025 12:06:09 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F ([2620:10d:c091:400::5:e19e])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fd24877949sm22887026d6.88.2025.06.23.12.06.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 12:06:09 -0700 (PDT)
Date: Mon, 23 Jun 2025 14:06:07 -0500
From: Gregory Price <gourry@gourry.net>
To: Bijan Tabatabai <bijan311@gmail.com>
Cc: damon@lists.linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	sj@kernel.org, akpm@linux-foundation.org, david@redhat.com,
	ziy@nvidia.com, matthew.brost@intel.com, joshua.hahnjy@gmail.com,
	rakie.kim@sk.com, byungchul@sk.com, ying.huang@linux.alibaba.com,
	apopple@nvidia.com, bijantabatab@micron.com,
	venkataravis@micron.com, emirakhur@micron.com, ajayjoshi@micron.com,
	vtavarespetr@micron.com
Subject: Re: [RFC PATCH v2 1/2] mm/mempolicy: Expose get_il_weight() to MM
Message-ID: <aFmln7KNVhE9-NIy@gourry-fedora-PF4VCD3F>
References: <20250620180458.5041-1-bijan311@gmail.com>
 <20250620180458.5041-2-bijan311@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250620180458.5041-2-bijan311@gmail.com>

On Fri, Jun 20, 2025 at 01:04:57PM -0500, Bijan Tabatabai wrote:
> From: Bijan Tabatabai <bijantabatab@micron.com>
> 
> This patch exposes get_il_weight() in mm/internal.h. This patch is to
> allow other parts of the MM subsystem, such as DAMON, to make page
> placement decisions based on the global interleave weights.
> 
> Signed-off-by: Bijan Tabatabai <bijantabatab@micron.com>

Reviewed-by: Gregory Price <gourry@gourry.net>
