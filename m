Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E99CD36D4E6;
	Thu, 26 Feb 2026 00:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772067559; cv=none; b=uRdlK8Znqvtc+a1aOpY+LuOGcT7xGpdMQ6c8qhkonMlMxXh1uvNpxKVZNylhLPQIC7rPzq5g23ySyWEJU1vQGHxmz6dBC+nQz2f7WNx0Ll1l+SfOk2pVutaMJshmOs2YVrke4G954g7VpfPx+EdOV0bFGEHg34mQ7VO6WQSrDNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772067559; c=relaxed/simple;
	bh=WgtMgVEJKBbw5rku/Ulb3PMFelZylX2qCcQghD/WKGY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dT0zbQvNYH/0akW9OSNYYuSlKttxcr5kDwvwLbcWGX7373An3pMovghYs5KcBc4S/34HMy2B8Z/I27iz35FDsMA2+XgzVIWrtocJuHSnJ2rWmOXoeQWFW6Tp/fqDrnjBjWEEJby6Xh5dhfns1D46YiMMeL5X6Fh+Z+DI/27G0cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aMNubDGH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aMNubDGH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A0BBC116D0;
	Thu, 26 Feb 2026 00:59:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772067558;
	bh=WgtMgVEJKBbw5rku/Ulb3PMFelZylX2qCcQghD/WKGY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aMNubDGHFO4gX9UZIZ0xL+udtZ8ylyA4aHsLnZPtS0UrNwyrlD1SemckyK6PmBSHi
	 vLI+hW533UdcQOdT2JUqkht2gmkGCP/Kvra+ZCn71s/jjGRKIGIKcfrnq8wnT1dcPf
	 E28L5kPqiXXB7spXLQNP/fQcufvcN8Ha+p33TAwetW+L5OcRjTpOlb2txC58tLrdJU
	 L5EADGe/7D6JStAQWd2u0fvJAgbcNgttvev5/8eKgKG7MoQoRbaY/QwYKZ3grCI3am
	 1QCpgTzsMRet9RN7sOldX3esvjswLpW+84aVTIDJDwynyJxvFt7U4lOmCwAukvd/I2
	 43I4Ix7qqd8vQ==
From: SeongJae Park <sj@kernel.org>
To: Ravi Jonnalagadda <ravis.opensrc@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	akpm@linux-foundation.org,
	corbet@lwn.net,
	bijan311@gmail.com,
	ajayjoshi@micron.com,
	honggyu.kim@sk.com,
	yunjeong.mun@sk.com
Subject: Re: [RFC PATCH v4 4/4] mm/damon: add PA-mode cache for eligible memory detection lag
Date: Wed, 25 Feb 2026 16:59:15 -0800
Message-ID: <20260226005916.7950-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <CALa+Y14yVxW+NSP6-G+93yHFLKhFhvKMQowGUR1MBcPgvO_q-A@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, 25 Feb 2026 10:58:15 -0800 Ravi Jonnalagadda <ravis.opensrc@gmail.com> wrote:

> On Mon, Feb 23, 2026 at 9:54 PM SeongJae Park <sj@kernel.org> wrote:
> >
> > On Mon, 23 Feb 2026 12:32:32 +0000 Ravi Jonnalagadda <ravis.opensrc@gmail.com> wrote:
[...]
> I agree with dropping this patch for now. Let's focus on getting the
> core metrics merged first.
> The cache mechanism can be revisited later if real-world usage shows
> it's needed.

Thank you for flexibly accepting my suggestion, Ravi.  I hope to continue more
discussions on the issue later.


Thanks,
SJ

[...]
