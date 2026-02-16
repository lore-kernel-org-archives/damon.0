Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30AE52745C;
	Mon, 16 Feb 2026 15:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771257161; cv=none; b=cCngFXtzT3DwY8SXrKc6MfN92Tw2iHpoZeAHxoacht5e9nb9EaCZxR7kpaO+vCZoRoTZchRCERNG1ad7Tkfn9FD8OtSZ+bFTRFDVpbf8MMw/eaNb4wiglaNGwr4LBM3ssMkokx2G6VpXOtbqJz3dunNOpH3uuNG3O7q7I7hjSMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771257161; c=relaxed/simple;
	bh=SpbM4tb01sW+yxj28CeMnTfRceSTmV4rtWURimYqVGI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PPzqHeGA6Qo5aDZ6rJngFxx2gOKWuS+t0AtkNamX9clmk6xMBCvaPwwniRNFFfH8uTZPfiYovgSL/hjEsKSSl8ToFR7nhlLxJNfiMgME0rr+FzWFFiATXUebLBEs6y8UTX+yy0Z3ShwLLlbVzKMqB3TGrKVKLHNITbFn32A9/I0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zlU1o7m/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zlU1o7m/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FADAC116C6;
	Mon, 16 Feb 2026 15:52:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771257161;
	bh=SpbM4tb01sW+yxj28CeMnTfRceSTmV4rtWURimYqVGI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=zlU1o7m/znn2lSnh8MTjRqRBK+DHHLT9wXb80dh7xfFbpKpDXbeb6TOWcO2DHZ/3K
	 IaaHlFJIaG2XWSeoYZRSohwqnk4huEZNc3KHK8hrRYO0GHJmQBIOd5laUOngcUyeox
	 V9Qjic/7NpwxPVr21WX6TnBZyYBbf5kE08GNNMp4=
Date: Mon, 16 Feb 2026 16:52:38 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Raul Pazemecxas De Andrade <raul_pazemecxas@hotmail.com>
Cc: "sj@kernel.org" <sj@kernel.org>,
	"security@kernel.org" <security@kernel.org>,
	"damon@lists.linux.dev" <damon@lists.linux.dev>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] mm/damon/core: dangling walk_control pointer in
 damos_walk() on inactive context
Message-ID: <2026021646-sandbox-duchess-5b7b@gregkh>
References: <CPUPR80MB8171025468965E583EF2490F956CA@CPUPR80MB8171.lamprd80.prod.outlook.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CPUPR80MB8171025468965E583EF2490F956CA@CPUPR80MB8171.lamprd80.prod.outlook.com>

On Mon, Feb 16, 2026 at 03:34:44PM +0000, Raul Pazemecxas De Andrade wrote:
> Root cause
> ----------
> 
> Commit bf0eaba0ff9c ("mm/damon/core: implement damos_walk()")
> introduced this function without cleanup on the -EINVAL error path.
> 
> The sibling function damon_call() had the exact same bug and was
> fixed in f9132fbc2e83 by adding damon_call_handle_inactive_ctx()
> which removes the control object when the context is inactive.
> damos_walk() has no equivalent cleanup.

Can you submit a patch to resolve this to get credit for fixing the bug?

thanks,

greg k-h
