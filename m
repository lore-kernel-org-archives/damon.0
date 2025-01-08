Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 154AC1FFC7B;
	Wed,  8 Jan 2025 17:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736357211; cv=none; b=LrTVa13OvG4lImGj315c3rJBA3jq5pBqRdKiis7uwj/vVG93/f0L5o1BU5ij9PG9+h3oF/FyhD/1I8uTW9L/sBRpODIRBsGE4O0hFILSecHrjjDMe2W7l8qJqTfS68d1G9IVXcjOO/ejIjJXX9hHFpPc+40+NmWawH+ct76l75Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736357211; c=relaxed/simple;
	bh=tIIhLJb11NqDqWXBo/NWi6wvo01S8sFAFxHTXh8cKV0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DB6IXkxyBnUqFB9Rgf7wA9Up1UMhndZ8JOEQouhRx6958kh4hIn8+6ajtaH4928KyNNtjGCyxA6Y6ZieK+Of3SCJYn6RPLBq0OVTyV0RSXN5r17ZcsEZbHISM5YVokUHvLjJ8TBFd/dbCqEP7GTz5UEChtQKfyBnkomJ2gbI1gU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hzH3em/1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hzH3em/1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F3D6C4CED3;
	Wed,  8 Jan 2025 17:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736357210;
	bh=tIIhLJb11NqDqWXBo/NWi6wvo01S8sFAFxHTXh8cKV0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hzH3em/1M8euyLT6vG28pOZjaQDQrNnyQvzgJ6XnQXUI2sDBbUzrEBNEbEGoTEaRe
	 EFKV/R/VhSGMhSl+s55L9lsE0w0m3ZPuITN5pKOsq9POkdyAB+IuvHyATwuWsQqNUv
	 /HGEGhvpW1NryBSe/1ozgV0ep6bK7zI72E/z+NsWoqmdyST6SImmryAEClSo1e7EVU
	 VmYw18MToWbBDVCrIlHVqXDblX5kfuQojJYqwqpmq4WhBh7T1VTJFIYv1YrN37Rx3Y
	 AeU1WLG5zQrkqb4EcqDaKVKxif1wEw6JD/LFUIaoUgCEoEPEnfjfoJc4YdmeYyNagh
	 lGTKu213UHydA==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	damon@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 07/10] Docs/mm/damon/design: document pass/block filters behaviors
Date: Wed,  8 Jan 2025 09:26:46 -0800
Message-Id: <20250108172646.6226-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250108040454.1283-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 7 Jan 2025 20:04:54 -0800 SeongJae Park <sj@kernel.org> wrote:

> On Tue, 7 Jan 2025 12:17:36 -0800 SeongJae Park <sj@kernel.org> wrote:
> 
[...]
> > +The fact that the action can be applied to any memory as long as no block
> > +filter explicitly excluded it means that installing pass filters without any
> > +block filter after those is same to not installing the pass filters, in terms
> > +of the ``action`` applying.  Statistics for DAMOS filters will still be
> > +accounted, though.
> 
> The above last sentence is right in a sense, but not useful and could only
> confuse readers.  The statistics for DAMOS filters are filters passed size
> stat, which is provided as per-scheme accumulated stat and per-region instant
> information.  The stat is for any memory that be able to apply the DAMOS action
> after the filters check stage.  Hence, whether it has passed the stage due to
> existence of a pass filter that matches the memory, or the absence of any
> matching filter is distinguishable.
> 
> > It is therefore still useful for monitoring purpose.
> 
> Hence, the above sentence is completely wrong.  The case (installing pass
> filtrs without any block filter after those) is not useful even for monitoring
> purpose.
> 
> The RFC version of this patch was mentioning it correctly, but was not clearly
> describing why it is not also useless for even monitoring purpose.  I was also
> confused due to the absence of the context.  I will rewrite this part and send
> the whole series again as v2.

Another reason that I was confused is the conflict of the term.  The term
'pass' at sz_filters_passed stat means passing through the filters checking
stage.  The same term 'pass' at "DAMOS pass filter" means it will let the
memory that matches to its criteria pass the stage.  Hence, the term for
'sz_filters_passed' is a superset of it for 'DAMOS pass filter'.  This is
obviously confusing.

I will rename things that introduced by this series to be called "allow"
instead of "pass" in v2.


Thanks,
SJ

> 
> 
> Thanks,
> SJ
> 
> [...]
