Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4071F218AAB;
	Fri, 20 Jun 2025 20:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750453102; cv=none; b=YcV17+X0FApPo9hnCqg3ad9ZS9EoIlYkSKL/1jhlURvF4TrbTfnRgWThfaojZddtS4eg/+57RmzJXGRmZd8TqEJYDiwOLV0Fq076fcGMxqgcyNWmpHsb0nwKp8ZNpUZqhmqAjzQNWUB5nKRSoUn9UjvTh0j/010kGy/nzr4wJYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750453102; c=relaxed/simple;
	bh=PJ9s7Yp+CB26ukisBHrBNNzmRrTsOaP4rmZGgzpJVGQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=a1o2TR+y65UZ7cff4A2PmK+vWuvS9WTMo/kSdBzoGVaYZrbO0aMnjjWofmh6DRPi4DYoFFqtm4kisCgUvMOVlVnDxVTeaw7P3umO+vcSzT9qBmRItoTz/UTB18rssyhmr6PEFP8WwadifMD1gfdPE8qs53Tj38VnCkoja3NMCvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZPNxL3YA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZPNxL3YA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FBAEC4CEE3;
	Fri, 20 Jun 2025 20:58:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750453101;
	bh=PJ9s7Yp+CB26ukisBHrBNNzmRrTsOaP4rmZGgzpJVGQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZPNxL3YAa6dG7FDAR61aSsrv0GVnwVdVD1EOceItX19CsduN25LUPyi8ybkdn6MM7
	 cOf2KhIcM2BXzhbyjOxvkm0AcLsGvW7g8TBUgKqdZwZD1gQDVPgYu8zIN1Y5d59Mt/
	 WqMWogz/g+boSGlXSNy9jsbibLxOVKxVRoMxqPGZed6E8g1c/DEDO7zuM6E1ZdssL5
	 PsfCitWqUZfRedUDIUkPK7C457LPMNjBj/vGHiCbWdkl6BjqALWB+JUs4Wih+QMKne
	 82mpPddrmnjPV86qPN4ayl+TjK3cVzEzLLelgRvAouIWwdHXBrPTQbH0ELDmxtCtUR
	 o9VfzAMGgh5ig==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: DAMON Beer/Coffee/Tea chat reminder for the week of 2025-06-23
Date: Fri, 20 Jun 2025 13:58:19 -0700
Message-Id: <20250620205819.98472-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250620204743.98321-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 20 Jun 2025 13:47:43 -0700 SeongJae Park <sj@kernel.org> wrote:
[...]
> Next four time slots that I reserved in advance are as below.
> 
> - 2025-06-23 (Mon) 18:00 PT (not yet reserved)
> - 2025-06-25 (Wed) 09:30 PT (not yet reserved)
> - 2025-06-30 (Mon) 18:00 PT (not yet reserved)
> - 2025-07-02 (Wed) 09:30 PT (not yet reserved)

Sorry, the last two are wrong.  The real reserved time slots are:

- 2025-06-23 (Mon) 18:00 PT (not yet reserved)
- 2025-06-25 (Wed) 09:30 PT (not yet reserved)
- 2025-07-07 (Mon) 18:00 PT (not yet reserved)
- 2025-07-09 (Wed) 09:30 PT (not yet reserved)


Thanks,
SJ

[...]
