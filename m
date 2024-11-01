Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD2CE182BD;
	Fri,  1 Nov 2024 00:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730420840; cv=none; b=EZv4HFC6pXOF2q4UUXUlsW8QZcWyLoo4/QPHzZP1VHpGc6Qn8qU2llqO676N29XofTxhO7k4q4SphvT/ySFdJ8ze+5tsQP7478436KrYpIY8eqZkrT4oKDN1lLyCkangiN+VLhqjvazKNVmshbch467BxeyLvhJdmE2DkJKRMGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730420840; c=relaxed/simple;
	bh=OlfHbnKYf3jceLglp+umq0NwX9Cc0rpQ2KwjAb7sLKQ=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=e1hEPy0cI1NqPoZJJykl4vDZEfR63H7dva1ANNUeNcOuPc36wtuUtKXEDOxVk0PpmlopOXo73Q9c+6M7AQI/xPgZ3pq4RQ2KX8VxEhOmND/InmI6lNARyptEztFZKGrtlYd8lOArPVSyd494NnvtOexeHl+ZBi73EVHdp66nW5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=00g056k+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="00g056k+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1C0AC4CEC3;
	Fri,  1 Nov 2024 00:27:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1730420840;
	bh=OlfHbnKYf3jceLglp+umq0NwX9Cc0rpQ2KwjAb7sLKQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=00g056k+tEkI32NIisZsCQvMYQp5ROzX9fOHTu1pAzX+o8FerDwSehyU7kto5XYpf
	 inT4CgZVj+9JnnHV5gFHuwZyLJq7wkQDJqo9OtdQ3H1s7yKFt1ykqrHIRvdyCue9ZE
	 lKxA/wiDhr7BiWZrCs7gxYaQo8og8Vd5Cud2qNMk=
Date: Thu, 31 Oct 2024 17:27:19 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: SeongJae Park <sj@kernel.org>
Cc: damon@lists.linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 kernel-team@meta.com
Subject: Re: [PATCH 0/2] mm/damon/core: fix handling of zero non-sampling
 intervals
Message-Id: <20241031172719.8051cdd90e3c2187c609bb4e@linux-foundation.org>
In-Reply-To: <20241031183757.49610-1-sj@kernel.org>
References: <20241031183757.49610-1-sj@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 31 Oct 2024 11:37:55 -0700 SeongJae Park <sj@kernel.org> wrote:

> DAMON's internal intervals accounting logic is not correctly handling
> non-sampling intervals of zero values for a wrong assumption.  This
> could cause unexpected monitoring behavior, and even result in infinite
> hang of DAMON sysfs interface user threads in case of zero aggregation
> interval.  Fix those by updating the intervals accounting logic.  For
> details of the root case and solutions, please refer to commit messages
> of fixes.

Thanks.  fyi, there has been email lossage here.

Only [2/2] hit my inbox.  Neither [1/2] not [2/2] are in my linux-mm
folder.  I found the whole series in my linux-kernel folder.
