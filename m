Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A632721D5BA
	for <damon@lists.linux.dev>; Thu, 27 Feb 2025 07:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740639853; cv=none; b=fMKyv6ESnwa8DSxXFTQ12fBboe3WQa/cu4G5UUXboCDjVIEi2RsSpGVYVVTOq0TB9ZOITTuuoh7ECz7nZ3KVovQse8ZkY2z7VQFzd3OKalw7bjmJ8t2G/d4a/HBm4HY20jtBBStGoTTkzuLSSvgjotVLm0XTYGVAvTEM/jhv7wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740639853; c=relaxed/simple;
	bh=wGhmY4K+cfsz+Ts0JI7fTq+0yQhI6j1x0t4HpKbP2FI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JvG2N6wdJdXanQhJUndzhlT8AsehxhdqOc3I7Y+gGS2CZciYOAyL91B6TAdFk9abpeEdpVf873NpyPONr8h98XBAp4KTs6adbgZHOnEAZ1GPTwpxVofQ3b1syu6Glne01RujWCZdAW2ZjF7Uz33QEDylZX37tCuvknc41MJZH4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JliqGplo; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JliqGplo"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-30a69c1a8d3so7330651fa.3
        for <damon@lists.linux.dev>; Wed, 26 Feb 2025 23:04:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740639850; x=1741244650; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5pSnAlORQX9yo5NqS9jLGuSkbz6XSEuBHk2B9Ea63/k=;
        b=JliqGplolKY93SbSz87TbSKuC8yJ/8GiYM3Gbx1iRxTw1dnk7luCmZjEFBxALPUkiZ
         3qj9wlwlGSRVaEwS2KA4TAZiygMEvYUYEyryh03t6obsSU6eptNZXitNRyd7JpAK/pMA
         AxgfqW7qHmhUnF8z6BJ+/DbMoufvxUoY9v+IXbuOWC61Wx4HY/bMlYi5iOhsWJoFjXvf
         hoieLbc+o4V4RoAhl8rPFNHR3ICqhUUE1IZeLs8s4px2PkxXBwFDvwqCO/kJktYni6gp
         nhINfF4ycdttRUrRqTyP7x9Y3c9LWai6lZoVBgQSu1XoXO5cZG0uNJOAt5+Nla5KN6+t
         eXSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740639850; x=1741244650;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5pSnAlORQX9yo5NqS9jLGuSkbz6XSEuBHk2B9Ea63/k=;
        b=w1r9V1fmx0/D2EzESX2d4YFbMTw30TrO7ovpFqySjK5r5EfPpgaYOmXocpQ/8FchP1
         Pjb7IAus4+faQZNxBlr34E5qJUA8wDfk8e0Lae/03j7klsmFA83ZYEb5YX9htvt1afqV
         K7K5D8b0Jpy4G1lWbw9uq7PYh+MWbCIlYI7dsus77M0ZErj7GMgdSJgB3Q7xlx4UhFVD
         QJ9y6//wDK6V3tB6Yxgjz7gWLRiEM/1+xxEYmaXM0HL72mbZ76Sz21dwg4GdhK9hNYe/
         bEA5p2LNS53OmiN+woVDMw7zSi2F/9ril4BRMhGyt4c/iVmgZsN+8Zbc2sNxZ9hX8r0c
         lh0g==
X-Forwarded-Encrypted: i=1; AJvYcCVQnANxRjT43HLC8+AhYpvyhM1z3P/usAqoWWLwMXMIi+kxKLa/Onmc4WKud+US5XEx79dp6w==@lists.linux.dev
X-Gm-Message-State: AOJu0YyZH0Inz/nlpwxxnooSxuvFtlQEgVbUVhV++dwgWFByDl4pkwXy
	5q3l3LSITldWdhSLeyJhYkbFwoBe1g6UhmS46FxE6WIfTiaqGieLJd1haTsmDIyeRCRQ7wfgHui
	pBPkKQYhucoGm68T9h+Cq71AifYk=
X-Gm-Gg: ASbGncsuGWWLOp0wiTtASz8EsDRUC01LEhxGYLYQAI3aLN8bIM+yLIqTvh6k8SdakmU
	cyYv+Z/oGVsmIK84ZpgEdgixHODhSuZ4rsAnATT1cLnsvvU2TesiUkS00YRYg5v9REaXKyA/c21
	09wTG1yz0=
X-Google-Smtp-Source: AGHT+IEJB9xY5jdV4yA0qX96NmnQQAhEOgjMykCaPQFjWaqdpoNDmqQyMdSO8o9a1TpCdng2oPuHncXDTZDKMC+urTU=
X-Received: by 2002:a05:651c:220a:b0:2ff:d0c4:5ffe with SMTP id
 38308e7fff4ca-30a5989ec23mr108942871fa.16.1740639849425; Wed, 26 Feb 2025
 23:04:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250226133703.3c9775c9e50e198abc9b9f6e@linux-foundation.org>
 <20250226225605.2000-1-sj@kernel.org> <CAJGd785Eu7iuVwYnewaUm38NJcKzB-xkZwdRiYR9Yo9Qwaoffg@mail.gmail.com>
In-Reply-To: <CAJGd785Eu7iuVwYnewaUm38NJcKzB-xkZwdRiYR9Yo9Qwaoffg@mail.gmail.com>
From: bus710 <bus710@gmail.com>
Date: Wed, 26 Feb 2025 23:03:57 -0800
X-Gm-Features: AQ5f1JpVLtjZYY8z8VdY3q00BIa0I40J0PTII1FHJ04t63xdJqRQe8KrnJyuBBs
Message-ID: <CAJGd784+kQ8NXSp1=9tZW+4wYvTh6SkW7ySaB0TVGcinjjcEdQ@mail.gmail.com>
Subject: Re: [PATCH] samples/damon: a typo in the kconfig - sameple
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, damon@lists.linux.dev, kernel-team@meta.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: multipart/mixed; boundary="000000000000e855b8062f1a4bde"

--000000000000e855b8062f1a4bde
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 26, 2025 at 3:07=E2=80=AFPM bus710 <bus710@gmail.com> wrote:
>
> On Wed, Feb 26, 2025 at 2:56=E2=80=AFPM SeongJae Park <sj@kernel.org> wro=
te:
> >
> > On Wed, 26 Feb 2025 13:37:03 -0800 Andrew Morton <akpm@linux-foundation=
.org> wrote:
> >
> > > On Wed, 26 Feb 2025 10:42:04 -0800 SeongJae Park <sj@kernel.org> wrot=
e:
> > >
> > > > From: bus710 <bus710@gmail.com>
> > >
> > > Full names are preferred, please.  Actually I think it's "required".
> >
> > Thank you for letting me clearly know this.  I'll request full names to=
 DAMON
> > patch authors from next time.
> >
> > bus710, we could still update the patch before it is merged into the ma=
inline.
> > If you could, please let us know your full name and if we can update th=
e patch
> > with that.
> >
> > >
> > > I'll apply it anyway due to the patch's minor nature, thanks.
> >
> > I agree this is a simple enough patch that the name doesn't really matt=
er.
> > Thank you Andrew :)
> >
> >
> > Thanks,
> > SJ
>
> Oh, yes. I was a little worried if I added too much noise for such a
> small work, but I shouldn't miss this opportunity to leave my name in
> Linux history.
> Let me prepare a new patch as soon as possible.

Hi all,

Please find the attached patch.
Based on the latest one, from @Andrew Morton I just replaced my ID
with my real name as well as updated the subject.

Thank you,
Seongjun Kim

--000000000000e855b8062f1a4bde
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0002-samples-damon-a-typo-in-the-kconfig-sameple.patch"
Content-Disposition: attachment; 
	filename="0002-samples-damon-a-typo-in-the-kconfig-sameple.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_m7n00g7d0>
X-Attachment-Id: f_m7n00g7d0

RnJvbTogU2VvbmdqdW4gS2ltIDxidXM3MTBAZ21haWwuY29tPgpTdWJqZWN0OiBbUEFUQ0ggdjJd
IHNhbXBsZXMvZGFtb246IGEgdHlwbyBpbiB0aGUga2NvbmZpZyAtIHNhbWVwbGUKRGF0ZTogV2Vk
LCAyNiBGZWIgMjAyNSAxMDo0MjowNCAtMDgwMAoKVGhlcmUgaXMgYSB0eXBvIGluIHRoZSBLY29u
ZmlnIGZpbGUgb2YgdGhlIGRhbW9uIHNhbXBsZSBtb2R1bGUuICBDb3JyZWN0Cml0OiBzL3NhbWVw
bGUvc2FtcGxlLwoKTGluazogaHR0cHM6Ly9sa21sLmtlcm5lbC5vcmcvci8yMDI1MDIyNjE4NDIw
NC4yOTM3MC0xLXNqQGtlcm5lbC5vcmcKU2lnbmVkLW9mZi1ieTogU2VvbmdqdW4gS2ltIDxidXM3
MTBAZ21haWwuY29tPgpTaWduZWQtb2ZmLWJ5OiBTZW9uZ0phZSBQYXJrIDxzakBrZXJuZWwub3Jn
PgpSZXZpZXdlZC1ieTogU2VvbmdKYWUgUGFyayA8c2pAa2VybmVsLm9yZz4KU2lnbmVkLW9mZi1i
eTogQW5kcmV3IE1vcnRvbiA8YWtwbUBsaW51eC1mb3VuZGF0aW9uLm9yZz4KLS0tCgogc2FtcGxl
cy9kYW1vbi9LY29uZmlnIHwgICAgNCArKy0tCiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25z
KCspLCAyIGRlbGV0aW9ucygtKQoKLS0tIGEvc2FtcGxlcy9kYW1vbi9LY29uZmlnfnNhbXBsZXMt
ZGFtb24tYS10eXBvLWluLXRoZS1rY29uZmlnLXNhbWVwbGUKKysrIGEvc2FtcGxlcy9kYW1vbi9L
Y29uZmlnCkBAIC0zLDcgKzMsNyBAQAogbWVudSAiREFNT04gU2FtcGxlcyIKCiBjb25maWcgU0FN
UExFX0RBTU9OX1dTU0UKLSAgICAgICBib29sICJEQU1PTiBzYW1lcGxlIG1vZHVsZSBmb3Igd29y
a2luZyBzZXQgc2l6ZSBlc3RpbWF0aW9uIgorICAgICAgIGJvb2wgIkRBTU9OIHNhbXBsZSBtb2R1
bGUgZm9yIHdvcmtpbmcgc2V0IHNpemUgZXN0aW1hdGlvbiIKICAgICAgICBkZXBlbmRzIG9uIERB
TU9OICYmIERBTU9OX1ZBRERSCiAgICAgICAgaGVscAogICAgICAgICAgVGhpcyBidWlsZHMgREFN
T04gc2FtcGxlIG1vZHVsZSBmb3Igd29ya2luZyBzZXQgc2l6ZSBlc3RpbWF0aW9uLgpAQCAtMTUs
NyArMTUsNyBAQCBjb25maWcgU0FNUExFX0RBTU9OX1dTU0UKICAgICAgICAgIElmIHVuc3VyZSwg
c2F5IE4uCgogY29uZmlnIFNBTVBMRV9EQU1PTl9QUkNMCi0gICAgICAgYm9vbCAiREFNT04gc2Ft
ZXBsZSBtb2R1bGUgZm9yIGFjY2Vzcy1hd2FyZSBwcm9hY3RpdmUgcmVjbGFtYXRpb24iCisgICAg
ICAgYm9vbCAiREFNT04gc2FtcGxlIG1vZHVsZSBmb3IgYWNjZXNzLWF3YXJlIHByb2FjdGl2ZSBy
ZWNsYW1hdGlvbiIKICAgICAgICBkZXBlbmRzIG9uIERBTU9OICYmIERBTU9OX1ZBRERSCiAgICAg
ICAgaGVscAogICAgICAgICAgVGhpcyBidWlsZHMgREFNT04gc2FtcGxlIG1vZHVsZSBmb3IgYWNj
ZXNzLWF3YXJlIHByb2FjdGl2ZQpfCg==
--000000000000e855b8062f1a4bde--
