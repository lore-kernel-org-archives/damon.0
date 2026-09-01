Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2925488211;
	Tue,  1 Sep 2026 17:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788283082; cv=none; b=MBYkxee1EHd75lr/nPA7QA85tKdD3yIPXuraj2BMc8F/n0EiU0bzDV2To6cbDLMK1lxhl8fYQ+ZfFaXSXipMvZr+u9wU75SFCdBpxLIWbKsHNRnph/PKipM5tgcwDiBWOZtqFVZpg1BaFqrci8UezgjeHfWO9ZB3pEyhpHX5afM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788283082; c=relaxed/simple;
	bh=RLHsiMQAj995DmYI+hUn8DbIOyFBdtMhVvy+1Z1N9vQ=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=AUmXOYaMAZg3EdVILQ2wrqOnKxEMS5xDe0VcMSCTRSFRU3FiYqzlvodj99EsVBTuglUBlat72nkGB3zMZlLpHXhuga0B4jajwQXwXIbaTXBkVo/9Z2YXmYWK1zDArLJIBfy/FTumeg659/CUQUVuzkWDo1b3PcfZNmRJqtrXAps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=GYUxjOp2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="GYUxjOp2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E46501F00A3A;
	Tue,  1 Sep 2026 17:18:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1788283081;
	bh=qNy8aFxk/AJak35WjwkPfrrpfkELAGWHw5uPOVPVzP4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=GYUxjOp2aphZq8mIT9V1j15Kpl/xo9Ln9v4wuPqsr237ZjQthjG2S/Cm+pgHRrToy
	 q7RvgwrTUkHmSI1XTvEJeWnKu9G+ltZt3D2FGhMia65IdemdDZlwxecKDiyFtHcdhG
	 34ITMNX9JAw7kJ5jWiQOynxvMukRw6KtAP1TQms4=
Date: Tue, 1 Sep 2026 10:18:00 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: SJ Park <sj@kernel.org>
Cc: "Liam R. Howlett" <liam@infradead.org>, David Hildenbrand
 <david@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Lorenzo Stoakes
 <ljs@kernel.org>, Michal Hocko <mhocko@suse.com>, Mike Rapoport
 <rppt@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, Shuah Khan
 <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, Suren
 Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@kernel.org>,
 damon@lists.linux.dev, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-mm@kvack.org
Subject: Re: [PATCH v1.1 00/17] mm/damon: introduce data access-as-a-data
 attribute
Message-Id: <20260901101800.0d76452eb310a4b958d792fd@linux-foundation.org>
In-Reply-To: <20260901132506.99243-1-sj@kernel.org>
References: <20260901132506.99243-1-sj@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  1 Sep 2026 06:24:47 -0700 SJ Park <sj@kernel.org> wrote:

> TL;DR: extend DAMON's data attributes monitoring system to support page
> table accessed bit and PG_idle based access monitoring.
> 

Thanks, added.

What does "v1.1" mean?
