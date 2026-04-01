Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89AE129405
	for <damon@lists.linux.dev>; Wed,  1 Apr 2026 18:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775066943; cv=none; b=BK8HH5RGZqzX5gdEGbeaJxpl8dc/B57arVd7lARq62g3TqO07tYC8oJAGXLcJO17j8mHtQcU9zk68xuJpi+O03ui3VhDxIoXT1yQtaqfBhzrrvjWQwceem4LJrdRvx+13Dkh6OUhcaz1ReNHoVW5obc8+OXQFTmceF9UDMQguL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775066943; c=relaxed/simple;
	bh=vkF4X7TUYXk4jWiVA1NUhGquCPkI5mnZgvk50He64aU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LKpHtKiixHjpswFRF/EA3PNzfmYxNZASjlxTGTLy9Fu2SCg5QJWhWzKMuA815k0UqoVqrpME24twNKj5RYjeKl+m9pGP0XGSAkVxOCGe+O+sExmHrhzgFu0+EKvvPl27e4DU26j0uJ9gh0ccYyGu7711IswzPZ2SdlTogxiXskY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EnBf34oP; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EnBf34oP"
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-2c160cb021cso109002eec.1
        for <damon@lists.linux.dev>; Wed, 01 Apr 2026 11:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775066941; x=1775671741; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lOudpFoWx8XSk/HnG+DRMg8OAxAthLf7Y5r1o4OCHrM=;
        b=EnBf34oP1/QXdnGmDERZZhbyxqKbaCQhUjQapD619jFJIL1Rn5qY0Ip5EM+RBj2yLa
         +MV4hQK7JQAYj7RIUqMRQUdkBnUde1rqj2RMVzqAJN7Mj7/cvELnrUKEMUF8OLneGipI
         c1D9NBM8K/XSY3ceGM0YLF+WU/jn2ld9QLlXeQ61BtR8vcqZtni5vi3hdmL8F5XiFhit
         IYbgJ+iTIZPy7Bc+cf9+Dp2jDOQTpXtazSHMaRExFOJCK1XjMqRk/f/j/DYHRZDdDswg
         UuSedupkKdgW+ZaGiUzq1nPJMunLY+0l62Ackxuxi9aOCaGl3FUetXwmQJITnDIYGcim
         YnpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775066941; x=1775671741;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lOudpFoWx8XSk/HnG+DRMg8OAxAthLf7Y5r1o4OCHrM=;
        b=rNgOw6LSfTxjJiC/wYFuIGFedtAWEx/Xn0XIptcDM4xKqkkI040WIxK2S/d2W31cJc
         N50/y+j4LAmT5qgsxLkGCwYO9lL9y6/rJeRtAGHMIHTrY39laRDMHYNZpjhOBL4/GhdI
         mUGViDLue3ssuvNZ6OJbjgEzDpJ2wejG7XCv8diRqROn3ZP+HzOurgV49gCLwpBFS6dH
         z+v+58OKXmFbqCgrRowXhq2u+AooHf6JYK3BkgEKBJF8f069yrkDk+NXBa5gVGTfuHf5
         4gfxYWWmwewp+oePRcrIAXNcJMDSDheVqgDYjqdoplg8wqnmRDyZgJFVasN/eUKkdDjE
         IhJQ==
X-Gm-Message-State: AOJu0YxZCrUIjRPbrDNMpdm12zfPx6Tzy//j7TE0VsjpLLVV/4N6y6lV
	5WdAKGZ4A1eX2qBuzmLrhr6rA+demBWgtGQsnLv0hUfrPDcX5wADQrLv
X-Gm-Gg: ATEYQzxXvYcJf8/WzFXz+ScYD5s51giQZ3RDf5SfDRI/4nDbA/0RkRXrWCjElHpHT8i
	RIKyrNY7Io0/cr8CgwAy8KdkEsqpg3R1wImpVPwP9LqjQttXIFkMruJtFlVcGiu0nrr9LrcHKRY
	RglQWqaVSsE1TJ/Nc20C1ZH+ajW45lfhCGvKW1heXgmK1cxH3Dwpb+rJdj45hJkBfplvyZZZAx6
	rS5nNvINnVhrivbZA/b5ZNEI3KIkO8H5qaTxAnChjhefjXwIfZGntWAcJ3GWeGd8ZXj9M6dY3an
	ocuv4p/TAZdyQy2683420V6bps0pAVbhemIl/rk0MEwUNf85019AvbnzezfYiXXR+9euRFKgah2
	5qA5HI/UgZndvuX8hSukZdGNSBLq33rrrDSUfVw+nzKwdIhQcyaEbh//73NvryTxdvEBVhrMDv+
	3qfUmav2dQDsDk3I4BiRmrYGrCZ9NO+OSd7mqD
X-Received: by 2002:a05:7300:a287:b0:2c5:3b87:2ffc with SMTP id 5a478bee46e88-2c930b800a4mr2410628eec.7.1775066941427;
        Wed, 01 Apr 2026 11:09:01 -0700 (PDT)
Received: from fedora ([2601:644:937c:6c90::c63a])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ca7d3111d1sm355429eec.30.2026.04.01.11.09.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 11:09:00 -0700 (PDT)
Date: Wed, 1 Apr 2026 11:08:58 -0700
From: Vishal Moola <vishal.moola@gmail.com>
To: SeongJae Park <sj@kernel.org>
Cc: damon@lists.linux.dev, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] MAINTAINERS: add sashiko as the first DAMON reviewer
Message-ID: <ac1fOrrURjCfQyJY@fedora>
References: <20260401162637.68506-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260401162637.68506-1-sj@kernel.org>

On Wed, Apr 01, 2026 at 09:26:36AM -0700, SeongJae Park wrote:
> sashiko did arguably good jobs at reviewing DAMON patches, for multiple
> cases.  "Today" is the greatest day to give sashiko a credit and the
> responsibility.  Add sashiko to MAINTAINERS file as a DAMON reviewer.

This is a great idea! Andrew should add it to the MM one too :P

> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 16874c32e288..42aeaa858531 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7041,6 +7041,7 @@ F:	drivers/platform/x86/dasharo-acpi.c
>  
>  DAMON
>  M:	SeongJae Park <sj@kernel.org>
> +R:	sashiko.dev

Maybe we should give it a kernel.org address while we're at it. It would
look more in place.

>  L:	damon@lists.linux.dev
>  L:	linux-mm@kvack.org
>  S:	Maintained
> 
> base-commit: 36cdacaadf95f0245cfcb76c0b0cb7e6706b05ea
> -- 
> 2.47.3
