Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 288E819F11B
	for <damon@lists.linux.dev>; Sun, 17 Aug 2025 17:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755450284; cv=none; b=Y/WGuQSkzyKAN4m9OTE1Cla+dzD2fJ2H7fWPXHXXmYt8Kfi5r8yeFZ1jPh9y75diNdyT/GQ4TPusWrNiDZvB9wj2fK2lWXAN8O0IZNPRZFLyREglFnN91+ykcYipi56YiufvqWl0NI/oGxUBJoNQHtLyHU2bIg0oTGDEPYAOg5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755450284; c=relaxed/simple;
	bh=KTWQtwe8r6oIJ7x+q3kv/WoFv4VvQPP2AkriCOou1Xw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pfkSjMJB6YWZW27oYB7M5bylh870Ggzjdz3ctNQNTItEcjhGCFXTYLFU6pfqu9fUTNK8YH5UlRKZbO8EmDNXE3cbdPoOEvGSzFjIxW+SoYBsxx6m2CvmIggGG1NYNn2h6EscnlKEVmYMVf+Y9SvmE+gEFJBYtylPy+Jpr9fdrMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XMy7gPQw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XMy7gPQw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 840C1C4CEEB;
	Sun, 17 Aug 2025 17:04:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755450283;
	bh=KTWQtwe8r6oIJ7x+q3kv/WoFv4VvQPP2AkriCOou1Xw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XMy7gPQwKc2CeZF7hxhYl7SdA4uPUsXfFIcw3Rp+eshqqCZYUzB24bpJmWSdPn++D
	 UwGTIgFWu2uRQfrWH8wkj323iIoKE7WZIp/7n/5f1EDwEFa4yO0518Ru9oxImP29Tk
	 f+nCiCRJOMhwo9/+GKq2AKGuOkxHIRMoxkDl9TK/mNHdQgEp61D3kmAFdkQUQNLdf8
	 /JEWDxc+bbQ8VxWv80PgEhpP+QBZ2+kDvf6RLhz/1CFYH5Kc+PO6Q0KK9UN4Yc0aO1
	 2MmIbmvMHcuLAsJuLdVVdI5T/AZGcT32JoCEJ/QkIBXiB/wQpBeKrD5bV9nbEZ5WWB
	 AGeYAgleigYEg==
From: SeongJae Park <sj@kernel.org>
To: Enze Li <lienze@kylinos.cn>
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	enze.li@gmx.com
Subject: Re: [PATCH v2] mm/damon/Kconfig: make DAMON_STAT_ENABLED_DEFAULT depend on DAMON_STAT
Date: Sun, 17 Aug 2025 10:04:41 -0700
Message-Id: <20250817170441.9817-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <bjoel05s.fsf@kylinos.cn>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 17 Aug 2025 18:20:31 +0800 Enze Li <lienze@kylinos.cn> wrote:

> Hi SJ,
> 
> On Fri, Aug 15 2025 at 09:59:03 AM -0700, SeongJae Park wrote:
> 
> > On Fri, 15 Aug 2025 17:21:10 +0800 Enze Li <lienze@kylinos.cn> wrote:
> >
> >> The DAMON_STAT_ENABLED_DEFAULT option is strongly tied to DAMON_STAT
> >> option -- enabling it alone is meaningless.  This patch makes
> >> DAMON_STAT_ENABLED_DEFAULT depend on DAMON_STAT, ensuring functional
> >
> > s/depend/depends/ ?
> 
> I'm not well-versed in grammar, but using 'depends on' here feels a bit
> weird to me.  After consulting grammar references, it seems to me that
> I've found the answer.
> 
> In *Collins COBUILD English Grammar 4th* (Section 3.210, titled
> transitive verbs with an infinitive without _to_), it says:
> 
> > A few verbs are followed by an object and an infinitive without to,
> > not an -ing participle or a to-infinitive.  They are let, make, and
> > have in the sense of cause to happen or experience.
> 
> It's somewhat like what we often call 'make the machine *work*'.  This
> is my understanding.  If I misunderstood or missed something, please let
> me know, I would be happy to submit v3 of the patch to fix the typo.

My English is really poor, so I believe you're right.  Thank you for correcting
me! :)


Thanks,
SJ

[...]
