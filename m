Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE39395260;
	Mon, 30 Mar 2026 06:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774852786; cv=none; b=n8pjtyXp/g0n76g9ozjaSRC21PyzpxXjNOj14E9Nq2eteGLobsno6/6RRcUQVWpFAYKw+dT6oM0HYwo7dboJBgBNmE7FVVE/bJ1Y7Td4ajJ2VBHAS1MlZUS2XRi2+yLjv0VBpOKvP0OSnyqcqLQEjjvWGSqX0pkemHeQMCSZFTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774852786; c=relaxed/simple;
	bh=myvvPZhxJ7EO6K8GpcgKd8hCovuJkekPgOgGCxsiNq0=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=B9J2LwAI5r2mu8r7KPT+nlTeyPtynkrSo3IOV0eESyccKDdY3rWXb+whLsyOSUyVT6BPfiH1g8JPXRJ6VN/qCzAt1YbMxNDj6Rydu10SwF2r8qeYSKWNDm/bH91F2H8o21xIIXhqbxLWyxlFvphhfIqm9qxW9Lg4luDD9OwvvNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=12cePyq/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="12cePyq/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13B72C19423;
	Mon, 30 Mar 2026 06:39:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1774852785;
	bh=myvvPZhxJ7EO6K8GpcgKd8hCovuJkekPgOgGCxsiNq0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=12cePyq/2vCuqfJDmg8TcTYpRMJ2OMOWS47EIlYsDlGjIaxMww4e0JilOZcFMt3/H
	 Lu2p19FVnGvIACrxhCRtany7kefk5oTWkjqCRJUDE2p9sLgrhSJdwU11RHEJ8btwoj
	 C/eznQgM0lXfTcIulvncGxHg3R94KrXlwdCK8KFg=
Date: Sun, 29 Mar 2026 23:39:44 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: SeongJae Park <sj@kernel.org>, "Liam R. Howlett"
 <Liam.Howlett@oracle.com>, "# 5 . 19 . x" <stable@vger.kernel.org>, David
 Hildenbrand <david@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Lorenzo
 Stoakes <ljs@kernel.org>, Michal Hocko <mhocko@suse.com>, Mike Rapoport
 <rppt@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, Suren
 Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@kernel.org>,
 damon@lists.linux.dev, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, Roman Gushchin
 <roman.gushchin@linux.dev>
Subject: Re: (sashiko status) [PATCH 0/2] Docs/admin-guide/mm/damon: warn
 commit_inputs vs other params race
Message-Id: <20260329233944.4bcf8a832a2ee1533c4a6613@linux-foundation.org>
In-Reply-To: <2026033013-drainage-stylized-43d6@gregkh>
References: <2026032915-library-embolism-b48c@gregkh>
	<20260329193226.59025-1-sj@kernel.org>
	<2026033013-drainage-stylized-43d6@gregkh>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 30 Mar 2026 07:47:54 +0200 Greg KH <gregkh@linuxfoundation.org> wrote:

> > And anyway I'm supposed to share at least my review of AI reviews, in mm
> > community.  If I ignore, I will only make Andrew have to reply asking that.

Actually no.  I see you're using Sashiko extensively so great, you'll
hear nothing more on Sashiko-vs-DAMON from me!
