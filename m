Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FDFB4B0CA9;
	Wed,  2 Sep 2026 22:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788388970; cv=none; b=HJ8In2HXlM/OBOkVvla0vARzdTy1yqnyc31T8jR2qoQGQd8F/d+8cRXVO2+DdEpa+PE0KHZnFD3pxGmd6pmm15RIzVkzq4QhsJqGHZjKgx0LSyzxDgwh7v/QiqUZNxTOFvP1lQz9Ea8L+jFMaOQSYNYov661JQ01qcaHdoFdmRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788388970; c=relaxed/simple;
	bh=0CxDJ4zzqrAd9J2csT+oYnQ+aiZpFGP/czS3FgAxbWQ=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=d+lK1MH0ep3hoUkGGPJyy3GAFmsbJMhLr/Sch8bzSDzW+gX3We82WyuioeratwOvksQPFHf3KmG3/n3T0FXM4WXQVIoiGFPqCR5LSpInaNe09WIYVsb+azZAZJNxoxEXmqtfuW/1shOOI3ZqRny2g63/Byf4ZSEVg/cGVOGX7ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=prHzxbiE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="prHzxbiE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C62C1F000E9;
	Wed,  2 Sep 2026 22:42:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1788388957;
	bh=pqO5LZhvHBtRdvbWaz/wBxjW/GfD1kqiQ2C9og7aMqo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=prHzxbiED94HyIQ7ik1B7ECmS7zcOCMeXkIHkC818VXVBLbk/R/jMpD/lxm7iERyM
	 uoGFJiqDb8MLxSYNs7OcvlydDZAkz2sGR1uqYT6kYhsuDJciw9PQ3XGs22Z8U+dk6k
	 K/AjesgeV+b5K/D0P3ZrrQXATJNrGeukzLcE1iAs=
Date: Wed, 2 Sep 2026 15:42:36 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: SJ Park <sj@kernel.org>
Cc: "Liam R. Howlett" <liam@infradead.org>, Brendan Higgins
 <brendan.higgins@linux.dev>, David Gow <davidgow@davidgow.net>, David
 Hildenbrand <david@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Lorenzo
 Stoakes <ljs@kernel.org>, Michal Hocko <mhocko@suse.com>, Mike Rapoport
 <rppt@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, Shuah Khan
 <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, Suren
 Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@kernel.org>,
 damon@lists.linux.dev, kunit-dev@googlegroups.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 00/12] mm/damon: cleanup code, add test cases, and
 update guidances in docs
Message-Id: <20260902154236.3f59f36fb51f3345a0f21906@linux-foundation.org>
In-Reply-To: <20260902054747.99370-1-sj@kernel.org>
References: <20260902054747.99370-1-sj@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  1 Sep 2026 22:47:33 -0700 SJ Park <sj@kernel.org> wrote:

> Misc cleanup, improvements and updates of code, test, and documents.
> 
> Patches 1-5 cleanup DAMON code.  Patches 6-10 adds kunit and selftest
> test cases for recently fixed bugs and a new feature.  Patches 11 and 12
> update guidelines for AI review and what document to read, on DAMON
> documents.

Thanks, I added all this.  Along with the fixup for [02/12].
