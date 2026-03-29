Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E246237CD24;
	Sun, 29 Mar 2026 18:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774807579; cv=none; b=oZM0s/Ld/xDNx8Ma5oI2gunbRyrRZhyPR/ldDOT05acmG97Yk8FXBIIyyH+ocK+dplSCAO2EboGaFeTZ4D+x9WULiEugJPu3En8zozCH6oqSyO6V0xGYOpoIzePMS+Ek208QOqqVHRwlzuCL55t3XiGwEXAmA66jmP1A5r0j1Cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774807579; c=relaxed/simple;
	bh=fYkZJVxP84Kryjvvaxn8j5axvqqmkHDBm6BWLUMry58=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M4cH9ERcww01J/vxQhrtssF14CT18R8Q5LoW/IKqztwGiTKd1EMBlkFwTo4rLy+Ss4V+Uobmuco85cdoYLLkNUeQge2RFzMj0HCz2non/mjY/RurLVmx3xEX4hFLVHBX1uT/LKQq5LLwj0YjuGzN26Y4dcOHyr1iR1HvoOb4b5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tr2tVTF1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tr2tVTF1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35054C116C6;
	Sun, 29 Mar 2026 18:06:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774807578;
	bh=fYkZJVxP84Kryjvvaxn8j5axvqqmkHDBm6BWLUMry58=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tr2tVTF1XGw3NZgrZZQHL68G9BeEHSGVLujgo17G1IKBrJ/dYvnpxvNoDUSVb3HA9
	 kqEA4qTJYDQRMZFPeoj+WNCZXsK3RdX7B+46ysB1VDXqyDEy2P3bosXeuXFHnjXIR7
	 zju9AB3mDNys/6B+xEyb+c20kZ7OT/eoa8FPdfQQ=
Date: Sun, 29 Mar 2026 20:05:53 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	"# 5 . 19 . x" <stable@vger.kernel.org>,
	David Hildenbrand <david@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, Lorenzo Stoakes <ljs@kernel.org>,
	Michal Hocko <mhocko@suse.com>, Mike Rapoport <rppt@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@kernel.org>, damon@lists.linux.dev,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: (sashiko status) [PATCH 0/2] Docs/admin-guide/mm/damon: warn
 commit_inputs vs other params race
Message-ID: <2026032915-library-embolism-b48c@gregkh>
References: <20260329153052.46657-1-sj@kernel.org>
 <20260329154917.47598-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260329154917.47598-1-sj@kernel.org>

On Sun, Mar 29, 2026 at 08:49:16AM -0700, SeongJae Park wrote:
> Forwarding sashiko.dev review status for this thread.
> 
> # review url: https://sashiko.dev/#/patchset/20260329153052.46657-1-sj@kernel.org

Why are you doing this?  If we want to see the review, can't we just go
and look at the tool itself?  sending it back to all of us feels odd,
especially when it is your own patches.

confused,

greg k-h
