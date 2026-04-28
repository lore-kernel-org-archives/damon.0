Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A27334F25C;
	Tue, 28 Apr 2026 07:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777361887; cv=none; b=f3vmwDeEirBdtl66ENk0oe0M5nNAFnTpMV9VyJX/8dE+CG4DJ/OEj5E3x+cbVDgXRy8CutjPRKGhiBe6UJsc8Ui8NB0ECqGw0vVTmqZWpKrS+ksCQiqmWCkMXKj1+QoBQ8CWGvawkb8vx/MN0elAJi/P54AeWzyjK4XYWYpRruc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777361887; c=relaxed/simple;
	bh=Fs2EdXEHwQhEBs2qS7lBmnFrIG342K7mhWLjyjsir6c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ux+DsMz+fGKaIKKY3kgIWS94jXbi5DuMDPRKl2jCe+mK88nt1LszRNmburXKKbs5YqneXhmetA4MxJhxoT0ujZZVobmE8pYWKDggGRCF/HjXrJtt2xBfS1AI0GD2SsvDohpQ8WVQA1IRISeJTzM9kD6b7v3uAhtEqKfSwYfboKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z9RrfqiJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z9RrfqiJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28593C2BCAF;
	Tue, 28 Apr 2026 07:38:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777361887;
	bh=Fs2EdXEHwQhEBs2qS7lBmnFrIG342K7mhWLjyjsir6c=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Z9RrfqiJuO4KdVG4NwIE8wOsqnLnSGMqhv0BTORUzQkkWJbCRGJtL+TZUO3X0wfo/
	 P32Q4DRtGd2sNV383uRrVpEqPYx/1jmmS6Q7/UYSzdFtD6rjIYET11K5maX0p9rwPJ
	 CxuLATOFhZY/DTbu+0CPHwNHd1lSChmJ4D8PUQuaJZLx+Ctsp/y9m8Q5HxzT8aN6vD
	 nshDqWSk+JkXE5fGiIECqlZnYLVtP3PzUyxveSla35Qg7qq8UOt8IYCQPFYtFpUMxr
	 7BFM3ypibEgUkk5HbUyoPAT+kclA50yhyS1sIB5NbiPTe8H+luqhQhAybLwtiQjvrp
	 LLpXfh29JQn5g==
Message-ID: <4b36424f-218d-46eb-88d2-a25f146fb792@kernel.org>
Date: Tue, 28 Apr 2026 09:38:02 +0200
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] Docs/admin-guide/mm/damon: fix 'parametrs' typo
Content-Language: en-US
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Cheng-Han Wu <hank20010209@gmail.com>, "Liam R. Howlett"
 <liam@infradead.org>, David Hildenbrand <david@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Lorenzo Stoakes <ljs@kernel.org>,
 Michal Hocko <mhocko@suse.com>, Mike Rapoport <rppt@kernel.org>,
 Shuah Khan <skhan@linuxfoundation.org>,
 Suren Baghdasaryan <surenb@google.com>, damon@lists.linux.dev,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20260427233927.146488-1-sj@kernel.org>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
In-Reply-To: <20260427233927.146488-1-sj@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/28/26 01:39, SeongJae Park wrote:
> On Sun, 26 Apr 2026 16:16:15 -0700 SeongJae Park <sj@kernel.org> wrote:
> 
>> From: Cheng-Han Wu <hank20010209@gmail.com>
>> 
>> Fix the misspelling of "parametrs" as "parameters" in
>> reclaim.rst and lru_sort.rst.
>> 
>> Signed-off-by: Cheng-Han Wu <hank20010209@gmail.com>
> 
> Oops, I forgot adding my Reviewed-by: tag.
> 
> Reviewed-by: SeongJae Park <sj@kernel.org>
> 
> Andrew, could you please add the above my Reviewed-by: tag?

Since you were sending that patch along in you series, there was (as it
must) already your S-o-b tag and that's stronger responsibility than a
Reviewed-by, so it's redundant to add it :)


> Thanks,
> SJ
> 
> [...]

