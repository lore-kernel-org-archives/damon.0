Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71DD73B5302;
	Mon, 23 Mar 2026 14:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774274473; cv=none; b=CwMFy434yvI1HJwSeJgeof7d98S90kVwoQg41g2okuOTEf/CyMqWzH2uLiW+Vm0/xDPBOvTphcrHyo2rlYSMZ+I5bPVsMuzYXY/OViyzA8cmc2/fx3IRv/IDY5fOWvzLcIFvtDLJ61weUxE3U8B8mF5eLhAK+ehOTaYsQ9FFl9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774274473; c=relaxed/simple;
	bh=9BwAZorS39eyV/Clw1DXueMD4DVME5MT6dI5zrJaohE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nRyvM04NO7nKyIX3+52YrcV7/k8UWdK9IK5vxI6bZjAt5P1MdrxNpZfI3qtKCNOHDGkDkQjOLILKGWPkqDtLu/FUe0LhEw2a8tHrDkiQRF4G8d0rlXcCF85W2AedFHV7ENDXMgBra+Xm+RQ7bxVdhaC5Xr4oPEw5Ng1UxbF+bb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ArxEKSWf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ArxEKSWf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2427CC4CEF7;
	Mon, 23 Mar 2026 14:01:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774274473;
	bh=9BwAZorS39eyV/Clw1DXueMD4DVME5MT6dI5zrJaohE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ArxEKSWfW0WLc+VbkYVX01vNzz8v12FbchqeuYr1vnlsn1zOJnD/ZJMSAaWEMz05v
	 +WlJqoJKeiyKbDdoX/ZCXR5dg34bqj2Chbp81L+e3jp2czB8mU/S09dvvujzNTKlru
	 PTASkdq4ZtVJezJPPKjredm/MavWfkXFUQswvqvX7RmwptzffWMqkl7VRfra0xrem8
	 udqYEWYMKYFj6sDVSalofeDKgpGXxaoG1t+bAkDIqHbi00vLMRtt9OK2o0qzhLiZaM
	 5JV/T1FJZI2st1gB0rMDQSY4SEkcA0xq9pkx9wLjk3f8p5P7lLcwgDlcz2v9rKb5Ir
	 6svipfbqGUx9g==
From: SeongJae Park <sj@kernel.org>
To: Josh Law <objecting@objecting.org>
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mm/damon/core: optimize kdamond_ap ply_schemes() by inverting scheme and region loops
Date: Mon, 23 Mar 2026 07:01:04 -0700
Message-ID: <20260323140106.79746-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <FEBF344D-3A99-4360-A286-705260B68704@objecting.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sun, 22 Mar 2026 22:39:11 +0000 Josh Law <objecting@objecting.org> wrote:
[...]
> Hi SeongJae,
> ​I understand your concerns regarding the behavioral changes and the adaptive regions mechanism. If the loop inversion is too intrusive for the current DAMOS semantics, I agree it's better not to force it.
> 
> ​Your suggestion to optimize the first loop by pre-filtering active schemes into a temporary list/array is interesting. It would achieve the O(Targets * Regions) skip for inactive schemes without changing the application order for active ones.
> 
> ​I'll take a look at whether that can be implemented simply enough to justify the overhead of managing the temporary list. If it looks too complex, I'll move on to other areas as you suggested.

Sounds good!

> ​Thanks for the detailed feedback and the guidance on DAMON's scaling philosophy.

No worries, I'm glad to help.


Thanks,
SJ

[...]
