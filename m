Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A85832E74F
	for <damon@lists.linux.dev>; Thu,  8 Jan 2026 20:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767903909; cv=none; b=BtQH8F3I3DVNvf8k9waG9MkALvQZYAa6GF6R4wavSH8BV3bRUUllG/GYfGXEjdqwWPk7NOUEw5GtSTuq/PbuH7iEEkiBNJZXO8PpljmP5yGqXvv3M/k1kzCUYRhcdLvvNXkUOdtBHZEARKxTj/nGyk1y2QLta3boaFB641v9D8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767903909; c=relaxed/simple;
	bh=XVfdVuCBvG2rp9iNO8J4pPYaLysLrDfmoMClySdA0sI=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=dhnyxGy42aAALqQ9x99/LFP4DKL/QYiWZfq586Yq/sAdlzVkIqca6r42dq+3KBxFsbPdEldmAUjxAkq0N2enzn02A1VY4ji10U0eLbDVt2CR23oKPbZOT7xpB4eJlwXeN8XmBwlnqjwMgVqbypgjXXovkC1LxP7a+tFWoxW0HXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ayMiNo98; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ayMiNo98"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82D4AC116C6;
	Thu,  8 Jan 2026 20:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1767903908;
	bh=XVfdVuCBvG2rp9iNO8J4pPYaLysLrDfmoMClySdA0sI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ayMiNo98qwCC+dSf1CS6jGRTFRoJdkTrajLzMKa7Wz6XAyknZD68CodPRWEpWIINd
	 x2ulKpHAzM0e+/EYYmDTtu27kPlegKjeIacNyeh13HYTMHAN4kbHRHqrq0D8ss9CK+
	 0ZwMdwNF1C7gTTiQ2lu+Ykb242+M7bcA28OE0noA=
Date: Thu, 8 Jan 2026 12:25:07 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: SeongJae Park <sj@kernel.org>
Cc: klourencodev@gmail.com, damon@lists.linux.dev, linux-mm@kvack.org, kevin
 <kevin@desktop-mu90jgd.home>
Subject: Re: [PATCH] mm/damon: fix typos in comments
Message-Id: <20260108122507.ad7e8a0520c1c58ccf4ebf36@linux-foundation.org>
In-Reply-To: <20260108051250.81675-1-sj@kernel.org>
References: <20251217222609.3355-1-sj@kernel.org>
	<20260108051250.81675-1-sj@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  7 Jan 2026 21:12:49 -0800 SeongJae Park <sj@kernel.org> wrote:

> > 
> > Reviewed-by: SeongJae Park <sj@kernel.org>
> 
> But I just found you didn't add the above Reviewed-by: tag from mine, to the
> patch.  Sorry for catching this late, but could you please add it to the patch?

yep, thanks.
